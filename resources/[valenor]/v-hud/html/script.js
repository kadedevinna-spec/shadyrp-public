let isOnHorse = false
let isTalking = false
let voiceAnimationInterval = null
const VOICE_BAR_COUNT = 15 // Number of waveform bars
const voiceBars = []

// Localization
let locales = {} // Store locales received from Lua

// Helper function to get localized string
function _L(key) {
    return locales[key] || key
}

// HUD Editor Variables
let isEditMode = false
let defaultPositions = {} // Store original HTML positions
let originalPositions = {}
let currentDraggable = null
let dragOffset = { x: 0, y: 0 }
let GRID_SIZE = 10 // 10px grid for snapping (now variable)
let hudConfig = {
    version: "1.0",
    layouts: {
        standart: {},
        normal: {},
        story: {}
    },
    currentLayout: "standart",
    customPositions: false,
    gridSize: 1.0, // 0.5-2.0 multiplier for grid snapping
    cinematicMode: false,
    hudVisibility: true, // HUD visibility state
    compassVisibility: true, // Compass visibility state
    colors: {
        health: '#F1EAD0',
        stamina: '#F1EAD0',
        water: '#F1EAD0',
        hunger: '#F1EAD0',
        brain: '#F1EAD0',
        bath: '#F1EAD0',
        toilet: '#F1EAD0',
        temparature: '#F1EAD0',
        'horse-health': '#F1EAD0',
        'horse-durabilty': '#F1EAD0',
        'horse-hud-group': '#F1EAD0',
        'details-time': '#F1EAD0',
        'details-date': '#F1EAD0',
        'details-weather': '#F1EAD0',
        'details-playerid': '#F1EAD0',
        'details-money': '#F1EAD0'
    },
    scales: {}, // Store element scale values
    visibilities: {} // Store element visibility states
}
let serverLayouts = null // Layouts received from config.lua

// Server-side disabled elements (from Config.HUDElements in config.lua)
// These override user preferences and cannot be changed in-game
let serverDisabledElements = {}

const HUD_ELEMENT_MAP = {
    Health: '.health',
    Stamina: '.stamina',
    Hunger: '.hunger',
    Thirst: '.water',
    Stress: '.brain',
    Bath: '.bath',
    Toilet: '.toilet',
    Temperature: '.temparature-group',
    HorseSpeed: '.horse-hud-group',
    HorseHealth: '.horse-health',
    HorseDurability: '.horse-durabilty',
    Compass: '.compass',
    Voice: '.voice',
    Money: '.details-group > .money',
    Time: '.details-group > .time:first',
    Date: '.details-group > .date',
    Weather: '.details-group > .weather-group',
    PlayerID: '.details-group > .time:last',
    WeaponPrimary: '.weapon-hud-group',
    WeaponSecondary: '.weapon-hud-group-secondary',
}

function applyServerHudElements(elements) {
    if (!elements) return
    serverDisabledElements = {}

    for (const [key, selector] of Object.entries(HUD_ELEMENT_MAP)) {
        if (elements[key] === false) {
            serverDisabledElements[selector] = true
            $(selector).hide()
        }
    }
}
let tempScaleValues = {} // Store temporary scale values before Save
let tempColors = {} // Store temporary color values before Save
let tempVisibilities = {} // Store temporary visibility values before Save
let savedHudVisibility = true // Original saved HUD visibility (for cancel)
let savedCompassVisibility = true // Original saved Compass visibility (for cancel)
let savedGridSize = 1.0 // Original saved grid size (for cancel)
let serverTheme = 'default' // Server theme name (from config.lua)
const defaultThemeColor = '#F1EAD0' // Default cream color for color pickers

// Theme color definitions
const themeColors = {
    'default': '#F1EAD0',   // Original cream
    'crimson': '#E74C3C',   // Red
    'gold': '#F1C40F',      // Gold/Yellow
    'emerald': '#2ECC71',   // Green
    'sapphire': '#3498DB',  // Blue
    'amethyst': '#9B59B6'   // Purple
}

// Apply server theme to HUD by adding class to body and updating CSS variable
function applyServerTheme(theme) {
    serverTheme = theme || 'default'
    const themeColor = themeColors[serverTheme] || themeColors['default']

    console.log('[v-hud] Applying theme:', serverTheme, 'Color:', themeColor)

    // Remove all theme classes
    document.body.classList.remove(
        'theme-default',
        'theme-crimson',
        'theme-gold',
        'theme-emerald',
        'theme-sapphire',
        'theme-amethyst'
    )

    // Add the selected theme class
    document.body.classList.add('theme-' + serverTheme)

    // Update CSS variable for theme color (affects circles, icons, text, bars)
    document.documentElement.style.setProperty('--theme-color', themeColor)

    // Update all circle elements with new color
    $('.circle').each(function () {
        const p = $(this).css('--p') || getComputedStyle(this).getPropertyValue('--p')
        $(this).css('background', `conic-gradient(${themeColor} calc(var(--p) * 3.6deg), transparent 0)`)
    })

    // Update other themed elements
    $('.icon-bg, .weather-celsius, .voice-icon-group').css('background-color', themeColor)
    $('.details-text, .current-speed').css('color', themeColor)
    $('.line').css('background', themeColor)
    $('.sounds.talking .voice-bar').css('background', themeColor)
}

// Cancel all temporary changes (scales, positions, colors)
function cancelAllChanges() {
    console.log('[v-hud] cancelAllChanges called, hudConfig.scales:', hudConfig.scales)

    // Restore scale values from saved config
    if (hudConfig.scales && Object.keys(hudConfig.scales).length > 0) {
        for (const selector in hudConfig.scales) {
            const savedScale = hudConfig.scales[selector]
            console.log('[v-hud] Restoring scale:', selector, '=', savedScale)
            $(selector).css('transform', `scale(${savedScale})`)

            // Update UI sliders
            const $slider = $(`.size-slider[data-element="${selector}"]`)
            if ($slider.length) {
                const min = 0.5
                const max = 2
                const range = max - min
                const percentage = ((savedScale - min) / range) * 100

                $slider.find('.size-slider-fill').css('width', percentage + '%')
                $slider.find('.size-slider-thumb').css('left', percentage + '%')
                $slider.closest('.size-set').find('.size-value').text(savedScale.toFixed(1))
            }
        }
    }

    // Restore sliders that don't have saved values to default (1.0)
    $('.size-slider[data-element]').each(function () {
        const selector = $(this).data('element')
        if (!hudConfig.scales || !hudConfig.scales[selector]) {
            console.log('[v-hud] Resetting to default:', selector, '(no saved value)')
            $(selector).css('transform', 'scale(1)')
            $(this).find('.size-slider-fill').css('width', '33.33%')
            $(this).find('.size-slider-thumb').css('left', '33.33%')
            $(this).closest('.size-set').find('.size-value').text('1.0')
        }
    })

    // Restore Grid Size slider and CSS variable using saved value
    hudConfig.gridSize = savedGridSize
    GRID_SIZE = savedGridSize * 10
    document.body.style.setProperty('--grid-size', GRID_SIZE + 'px')
    const $gridSlider = $('#grid-size-slider')
    if ($gridSlider.length) {
        const min = 0.5
        const max = 2
        const range = max - min
        const percentage = ((savedGridSize - min) / range) * 100
        $gridSlider.find('.size-slider-fill').css('width', percentage + '%')
        $gridSlider.find('.size-slider-thumb').css('left', percentage + '%')
        $gridSlider.closest('.size-set').find('.size-value').text(savedGridSize.toFixed(1))
    }

    // Restore pending layout change (if any)
    if (hudConfig.pendingLayout) {
        // Restore saved layout
        const savedLayout = hudConfig.currentLayout || 'standart'
        applyLayout(savedLayout)
        hudConfig.pendingLayout = null
    }

    // Restore color values from saved config (using server theme color)
    const defaultColors = {
        'voice-color': defaultThemeColor,
        health: defaultThemeColor, stamina: defaultThemeColor, water: defaultThemeColor, hunger: defaultThemeColor,
        brain: defaultThemeColor, bath: defaultThemeColor, toilet: defaultThemeColor,
        'horse-health': defaultThemeColor, 'horse-durabilty': defaultThemeColor,
        'details-time': defaultThemeColor, 'details-date': defaultThemeColor, 'details-weather': defaultThemeColor,
        'details-playerid': defaultThemeColor, 'details-money': defaultThemeColor
    }
    const detailsTargetMapCancel = {
        'details-time': '.details-group > .time:first',
        'details-date': '.details-group > .date',
        'details-weather': '.details-group > .weather-group',
        'details-playerid': '.details-group > .time:last',
        'details-money': '.details-group > .money'
    }
    $('.color-picker-input').each(function () {
        const $input = $(this)
        const target = $input.data('target')
        const savedColor = (hudConfig.colors && hudConfig.colors[target]) || defaultColors[target] || defaultThemeColor

        $input.prop('value', savedColor)
        const $wrapper = $input.closest('.color-picker-preview')
        $wrapper.find('.color-code').text(savedColor)
        $wrapper.find('.color-square').css('background-color', savedColor)

        // Handle details group colors (icon-bg + details-text)
        if (target.startsWith('details-')) {
            const selector = detailsTargetMapCancel[target]
            if (selector) {
                $(`${selector} .icon-bg`).css('background-color', savedColor)
                $(`${selector} .details-text`).css('color', savedColor)
                // Also update weather-celsius background for weather
                if (target === 'details-weather') {
                    $(`${selector} .weather-celsius`).css('background-color', savedColor)
                }
            }
        } else if (target === 'voice-color') {
            // Apply color to voice icon and all voice bars
            $('.voice-icon-group').css('background-color', savedColor)
            $('.sounds .voice-bar').css('background', savedColor)
        } else {
            $(`.${target} .circle`).css('background', `conic-gradient(${savedColor} calc(var(--p) * 3.6deg), transparent 0)`)
        }
    })

    // Restore HUD Visibility checkbox and container to saved state
    const $hudVisCheckbox = $('#hud-visibility-checkbox')
    if ($hudVisCheckbox.length) {
        hudConfig.hudVisibility = savedHudVisibility
        if (savedHudVisibility === false) {
            $hudVisCheckbox.addClass('off')
            $hudVisCheckbox.html('OFF<div class="checkbox-dot"></div>')
            $('.hud-main-container').hide()
            $.post("https://v-hud/toggleHudVisibility", JSON.stringify({ visible: false }))
        } else {
            $hudVisCheckbox.removeClass('off')
            $hudVisCheckbox.html('ON<div class="checkbox-dot"></div>')
            $('.hud-main-container').show()
            $.post("https://v-hud/toggleHudVisibility", JSON.stringify({ visible: true }))
        }
    }

    // Restore Compass Visibility checkbox and container to saved state
    const $compassVisCheckbox = $('#compass-visibility-checkbox')
    if ($compassVisCheckbox.length) {
        hudConfig.compassVisibility = savedCompassVisibility
        if (savedCompassVisibility === false) {
            $compassVisCheckbox.addClass('off')
            $compassVisCheckbox.html('OFF<div class="checkbox-dot"></div>')
            $('.compass').fadeOut(300)
        } else {
            $compassVisCheckbox.removeClass('off')
            $compassVisCheckbox.html('ON<div class="checkbox-dot"></div>')
            $('.compass').fadeIn(300)
        }
    }

    // Restore element visibility states from saved config
    $('.hud-settings-checkbox[data-element]').each(function () {
        const $checkbox = $(this)
        const elementSelector = $checkbox.data('element')

        // Skip special checkboxes
        if ($checkbox.attr('id') || $checkbox.hasClass('voice-follow-head-checkbox') || $checkbox.hasClass('voice-talk-only-checkbox')) {
            return
        }

        // Skip elements disabled by server config (Config.HUDElements)
        if (serverDisabledElements[elementSelector]) {
            $(elementSelector).hide()
            return
        }

        // Get saved visibility (default to true/visible)
        const savedVisible = hudConfig.visibilities && hudConfig.visibilities[elementSelector] !== undefined
            ? hudConfig.visibilities[elementSelector]
            : true

        if (savedVisible === false) {
            $checkbox.addClass('off')
            $checkbox.contents().filter(function () { return this.nodeType === 3 }).remove()
            $checkbox.prepend(_L('toggle_off') || 'OFF')
            $(elementSelector).hide()
        } else {
            $checkbox.removeClass('off')
            $checkbox.contents().filter(function () { return this.nodeType === 3 }).remove()
            $checkbox.prepend(_L('toggle_on') || 'ON')
            $(elementSelector).show()
        }
    })

    // Clear temporary values
    tempScaleValues = {}
    tempColors = {}
    tempVisibilities = {}

    // Re-apply server theme to override any localStorage colors
    applyServerTheme(serverTheme)
}

// Export helper - can be called directly from console
// Exports in VW (viewport width) units for responsive design
window.exportHUD = function () {
    const layout = {}
    const selectors = getDraggableElements()

    // Helper function to convert PX to VW (base: 1920px = 100vw)
    const pxToVw = (px) => {
        const vw = (px * 100) / 1920
        return vw.toFixed(4) + 'vw'
    }

    selectors.forEach(selector => {
        const $el = $(selector)
        if ($el.length) {
            let offset = $el.offset()

            // Special handling for weapon-hud-group if not in edit mode (uses absolute + margin)
            if (selector === '.weapon-hud-group' && $el.css('position') === 'absolute') {
                const marginLeft = parseFloat($el.css('margin-left')) || 0
                const marginTop = parseFloat($el.css('margin-top')) || 0
                offset = {
                    left: marginLeft,
                    top: marginTop
                }
            }

            layout[selector] = {
                position: 'fixed', // Always export as fixed for consistency
                left: pxToVw(offset.left),
                top: pxToVw(offset.top),
                marginLeft: '0vw',
                marginTop: '0vw',
                transform: $el.css('transform')
            }
        }
    })

    const data = {
        version: "1.0",
        exported: new Date().toISOString(),
        baseResolution: "1920x1080",
        layout: layout
    }

    const jsonStr = JSON.stringify(data, null, 2)

    navigator.clipboard.writeText(jsonStr).then(() => {

    }).catch(err => {

    })
}

// HUD Menu Drag functionality - allows dragging the settings menu by its header
let menuDragState = {
    isDragging: false,
    startX: 0,
    startY: 0,
    menuStartX: 0,
    menuStartY: 0
}

function initializeMenuDrag() {
    const $menu = $('.hud-menu-container')
    const $header = $('.hud-top-group')

    // Set cursor style on header to indicate draggable
    $header.css('cursor', 'move')

    // Mouse down on header - start drag
    $header.on('mousedown', function (e) {
        // Don't start drag if clicking on close button
        if ($(e.target).closest('.settings-close').length) {
            return
        }

        e.preventDefault()
        menuDragState.isDragging = true

        // Get current menu position
        const menuOffset = $menu.offset()
        menuDragState.menuStartX = menuOffset.left
        menuDragState.menuStartY = menuOffset.top
        menuDragState.startX = e.clientX
        menuDragState.startY = e.clientY

        // Remove transform and set position to fixed with current coords
        $menu.css({
            'position': 'fixed',
            'left': menuDragState.menuStartX + 'px',
            'top': menuDragState.menuStartY + 'px',
            'transform': 'none'
        })

        $header.css('cursor', 'grabbing')
    })

    // Mouse move - update position while dragging
    $(document).on('mousemove', function (e) {
        if (!menuDragState.isDragging) return

        const deltaX = e.clientX - menuDragState.startX
        const deltaY = e.clientY - menuDragState.startY

        let newX = menuDragState.menuStartX + deltaX
        let newY = menuDragState.menuStartY + deltaY

        // Keep menu within screen bounds
        const menuWidth = $menu.outerWidth()
        const menuHeight = $menu.outerHeight()
        const windowWidth = $(window).width()
        const windowHeight = $(window).height()

        newX = Math.max(0, Math.min(newX, windowWidth - menuWidth))
        newY = Math.max(0, Math.min(newY, windowHeight - menuHeight))

        $menu.css({
            'left': newX + 'px',
            'top': newY + 'px'
        })
    })

    // Mouse up - stop dragging
    $(document).on('mouseup', function () {
        if (menuDragState.isDragging) {
            menuDragState.isDragging = false
            $header.css('cursor', 'move')
        }
    })
}

// Reset menu position to center when menu is opened
function resetMenuPosition() {
    const $menu = $('.hud-menu-container')
    $menu.css({
        'position': 'fixed',
        'left': '50%',
        'top': '50%',
        'transform': 'translate(-50%, -50%)'
    })
}

$(document).ready(function () {
    // Apply default theme on page load
    applyServerTheme('default')

    // Initialize voice waveform bars
    initializeVoiceWaveform()

    // Initialize Compass (Added)
    initializeCompass()

    // Initialize HUD Menu Drag functionality
    initializeMenuDrag()

    // HUD başlangıçta gizli - sadece karakter yüklendiğinde (open-ui) görünür olacak
    $(".hud-main-container").hide()

    $(".horse-hud-group").css("visibility", "hidden")
    $(".horse-health").css("visibility", "hidden")
    $(".horse-durabilty").css("visibility", "hidden")
    $(".weapon-hud-group").hide()

    // Category item click handler
    $(document).on("click", ".category-item", function () {
        const categoryName = $(this).data("category")

        // Remove active class from all category items
        $(".category-item").removeClass("active")

        // Add active class to clicked item (CSS will apply theme filter automatically)
        $(this).addClass("active")

        // Fade out current page
        $(".hud-page.active").removeClass("active")

        // Fade in new page after fadeout completes
        setTimeout(() => {
            $(`.hud-page[data-page="${categoryName}"]`).addClass("active")
        }, 150)
    })

    // Settings close button - Cancel changes
    $(".settings-close").on("click", function () {
        cancelAllChanges()
        $.post("https://v-hud/closeHudMenu", JSON.stringify({}))
    })

    // Apply imported layout button - Imports ALL customizable settings
    $(".apply-input-group-apply-btn").on("click", function () {
        const inputValue = $(".apply-input-group-inp").val().trim()

        if (!inputValue) {
            $.post("https://v-hud/showNotification", JSON.stringify({
                text: _L("enter_layout_code"),
                type: "error"
            }))
            return
        }

        try {
            const importedData = JSON.parse(inputValue)

            if (!importedData || typeof importedData !== 'object') {
                throw new Error("Invalid layout structure")
            }

            // Check if this is v2.0 format (with positions, colors, scales, settings)
            const isV2Format = importedData.version === '2.0' && importedData.positions

            if (isV2Format) {
                // Apply positions
                if (importedData.positions) {
                    applyImportedLayout(importedData.positions)
                }

                // Apply colors
                if (importedData.colors) {
                    const detailsMap = {
                        'details-time': '.details-group > .time:first',
                        'details-date': '.details-group > .date',
                        'details-weather': '.details-group > .weather-group',
                        'details-playerid': '.details-group > .time:last',
                        'details-money': '.details-group > .money'
                    }

                    for (const target in importedData.colors) {
                        const color = importedData.colors[target]
                        hudConfig.colors[target] = color

                        // Update UI
                        const $input = $(`.color-picker-input[data-target="${target}"]`)
                        if ($input.length) {
                            $input.prop('value', color)
                            const $wrapper = $input.closest('.color-picker-preview')
                            $wrapper.find('.color-code').text(color)
                            $wrapper.find('.color-square').css('background-color', color)
                        }

                        // Apply to element - handle details vs metabolism
                        if (target.startsWith('details-')) {
                            const selector = detailsMap[target]
                            if (selector) {
                                $(`${selector} .icon-bg`).css('background-color', color)
                                $(`${selector} .details-text`).css('color', color)
                                // Also update weather-celsius background for weather
                                if (target === 'details-weather') {
                                    $(`${selector} .weather-celsius`).css('background-color', color)
                                }
                            }
                        } else {
                            $(`.${target} .circle`).css('background', `conic-gradient(${color} calc(var(--p) * 3.6deg), transparent 0)`)
                        }
                    }
                }

                // Apply scales
                if (importedData.scales) {
                    for (const selector in importedData.scales) {
                        const scale = importedData.scales[selector]
                        hudConfig.scales[selector] = scale
                        $(selector).css('transform', `scale(${scale})`)

                        // Update UI slider
                        const $slider = $(`.size-slider[data-element="${selector}"]`)
                        if ($slider.length) {
                            const min = 0.5, max = 2, range = max - min
                            const percentage = ((scale - min) / range) * 100
                            $slider.find('.size-slider-fill').css('width', percentage + '%')
                            $slider.find('.size-slider-thumb').css('left', percentage + '%')
                            $slider.closest('.size-set').find('.size-value').text(scale.toFixed(1))
                        }
                    }
                }

                // Apply settings
                if (importedData.settings) {
                    if (importedData.settings.gridSize !== undefined) {
                        hudConfig.gridSize = importedData.settings.gridSize
                        GRID_SIZE = hudConfig.gridSize * 10
                        document.body.style.setProperty('--grid-size', GRID_SIZE + 'px')

                        // Update grid slider UI
                        const $gridSlider = $('#grid-size-slider')
                        if ($gridSlider.length) {
                            const min = 0.5, max = 2, range = max - min
                            const percentage = ((hudConfig.gridSize - min) / range) * 100
                            $gridSlider.find('.size-slider-fill').css('width', percentage + '%')
                            $gridSlider.find('.size-slider-thumb').css('left', percentage + '%')
                            $gridSlider.closest('.size-set').find('.size-value').text(hudConfig.gridSize.toFixed(1))
                        }
                    }
                }
            } else {
                // Legacy format - positions only
                const requiredSelectors = getDraggableElements()
                let validElements = 0

                for (const selector in importedData) {
                    const element = importedData[selector]
                    if (!requiredSelectors.includes(selector)) continue
                    if (element.left && element.top) validElements++
                }

                if (validElements < requiredSelectors.length * 0.5) {
                    $.post("https://v-hud/showNotification", JSON.stringify({
                        text: _L("layout_not_compatible"),
                        type: "error"
                    }))
                    return
                }

                applyImportedLayout(importedData)
            }

            // Save config
            hudConfig.customPositions = true
            saveHUDConfig()
            savedGridSize = hudConfig.gridSize
            savedHudVisibility = hudConfig.hudVisibility
            savedCompassVisibility = hudConfig.compassVisibility

            $(".apply-input-group-inp").val('')
            updateLayoutButtons()

            $.post("https://v-hud/showNotification", JSON.stringify({
                text: _L("settings_imported"),
                type: "success"
            }))

        } catch (error) {
            console.error('Import error:', error)
            $.post("https://v-hud/showNotification", JSON.stringify({
                text: _L("invalid_code"),
                type: "error"
            }))
        }
    })

    // ESC key to close HUD menu (only if not in edit mode) - Cancel changes
    $(document).keyup(function (e) {
        if (e.key === "Escape" && !isEditMode) {
            if ($(".hud-menu-container").hasClass("show")) {
                cancelAllChanges()
                $.post("https://v-hud/closeHudMenu", JSON.stringify({}))
            }
        }
    })

    window.addEventListener("message", function (event) {
        const data = event.data

        if (data.action == "open-ui") {
            // Receive locales from Lua
            if (data.locales) {
                locales = data.locales
                applyLocales() // Apply locales to UI
            }

            // Apply server theme (from config.lua)
            if (data.theme) {
                applyServerTheme(data.theme)
            }

            // Apply server-side element toggles (Config.HUDElements in config.lua)
            if (data.hudElements) {
                applyServerHudElements(data.hudElements)
            }

            // Apply saved element visibility states
            applySavedVisibilities()

            // Only show HUD container if visibility is enabled
            if (hudConfig.hudVisibility !== false) {
                $(".hud-main-container").fadeIn(250)
            }

            // Receive HUD layouts from config.lua
            if (data.hudLayouts) {
                serverLayouts = data.hudLayouts

                // Save default positions
                saveDefaultPositions()

                // Apply saved user layout or default
                if (hudConfig.customPositions && hudConfig.layouts[hudConfig.currentLayout] &&
                    Object.keys(hudConfig.layouts[hudConfig.currentLayout]).length > 0) {
                    applyLayout(hudConfig.currentLayout)
                } else if (serverLayouts[hudConfig.currentLayout]) {
                    applyLayout(hudConfig.currentLayout)
                }
            }

            // Apply saved scale values AFTER layout (layout may reset transforms)
            loadSavedScales()
        }

        if (data.action == "close-ui") {
            $(".hud-main-container").fadeOut(250)
        }

        if (data.action == "open-hud-menu") {
            // Receive locales from Lua
            if (data.locales) {
                locales = data.locales
                applyLocales() // Apply locales to UI
            }

            // Apply server theme (from config.lua)
            if (data.theme) {
                applyServerTheme(data.theme)
            }

            // If HUD visibility is OFF or cinematic mode is ON, move menu to body so it's visible
            if (hudConfig.hudVisibility === false || hudConfig.cinematicMode === true) {
                $('.hud-menu-container').appendTo('body')
            }
            // Reset menu position to center before showing
            resetMenuPosition()
            $(".hud-menu-container").addClass("show")
            // Update layout button states when menu opens
            updateLayoutButtons()

            // Initialize sliders with saved scale values when menu opens
            updateSlidersFromConfig()
        }

        if (data.action == "close-hud-menu") {
            $(".hud-menu-container").removeClass("show")
            // Move menu back to hud-main-container only if HUD is visible and not in cinematic mode
            if ($('.hud-menu-container').parent().is('body')) {
                if (hudConfig.hudVisibility !== false && hudConfig.cinematicMode !== true) {
                    $('.hud-menu-container').appendTo('.hud-main-container')
                }
            }
        }

        if (data.action == "bladder-effect") {
            if (data.active) {
                $(".bladder-vignette").addClass("active")
            } else {
                $(".bladder-vignette").removeClass("active")
            }
        }

        if (data.action == "temperature-effect") {
            // data.type can be "hot", "cold", or "none"
            if (data.type === "hot") {
                $(".cold-vignette").removeClass("active")
                $(".hot-vignette").addClass("active")
            } else if (data.type === "cold") {
                $(".hot-vignette").removeClass("active")
                $(".cold-vignette").addClass("active")
            } else {
                // type === "none" - remove both effects
                $(".hot-vignette").removeClass("active")
                $(".cold-vignette").removeClass("active")
            }
        }

        if (data.action == "poison-effect") {
            // data.active can be true or false
            if (data.active) {
                $(".poison-vignette").addClass("active")
            } else {
                $(".poison-vignette").removeClass("active")
            }
        }

        if (data.action == "updateVoicePosition") {
            if ($('.voice').hasClass('follow-head')) {
                $('.voice').css({
                    'left': data.x + 'vw',
                    'top': data.y + 'vh'
                })
            }
        }

        if (data.action == "update-compass") {
            let heading = data.heading;
            if (heading === undefined && data.degree !== undefined) heading = data.degree;
            updateCompassUI(heading)
        }

        if (data.action == "horse-state-changed") {
            isOnHorse = data.isOnHorse

            // Don't hide/show horse elements in edit mode
            if (isEditMode) {
                // Still update isOnHorse state but don't change visibility
                return
            }

            if (isOnHorse) {
                if (!serverDisabledElements['.horse-hud-group']) $(".horse-hud-group").css("visibility", "visible")
                if (!serverDisabledElements['.horse-health']) $(".horse-health").css("visibility", "visible")
                if (!serverDisabledElements['.horse-durabilty']) $(".horse-durabilty").css("visibility", "visible")

                // Only add horse-mounted class if using default positions
                if (!hudConfig.customPositions) {
                    $(".hud-group").addClass("horse-mounted")
                }
            } else {
                if (!serverDisabledElements['.horse-hud-group']) $(".horse-hud-group").css("visibility", "hidden")
                if (!serverDisabledElements['.horse-health']) $(".horse-health").css("visibility", "hidden")
                if (!serverDisabledElements['.horse-durabilty']) $(".horse-durabilty").css("visibility", "hidden")

                // Only remove horse-mounted class if using default positions
                if (!hudConfig.customPositions) {
                    $(".hud-group").removeClass("horse-mounted")
                }
            }
        }

        if (data.action == "voice-state-changed") {
            isTalking = data.isTalking

            if (isTalking) {
                startVoiceAnimation()
            } else {
                stopVoiceAnimation()
            }
        }

        if (data.action == "update-stats") {
            if (data.health !== undefined) {
                $(".health .circle").css("--p", data.health)
            }
            if (data.stamina !== undefined) {
                $(".stamina .circle").css("--p", data.stamina)
            }
            if (data.hunger !== undefined) {
                $(".hunger .circle").css("--p", data.hunger)
            }
            if (data.thirst !== undefined) {
                $(".water .circle").css("--p", data.thirst)
            }
            if (data.stress !== undefined) {
                $(".brain .circle").css("--p", data.stress)
            }
            if (data.bath !== undefined) {
                $(".bath .circle").css("--p", data.bath)
            }
            if (data.toilet !== undefined) {
                $(".toilet .circle").css("--p", data.toilet)
            }
            if (data.horseHealth !== undefined && isOnHorse) {
                $(".horse-health .circle").css("--p", data.horseHealth)
            }
            if (data.horseStamina !== undefined && isOnHorse) {
                // Update both the durability circle and the stamina line
                $(".horse-durabilty .circle").css("--p", data.horseStamina)

                // maxWidth should match .stamina-line-bg width (12.2396vw)
                const maxWidth = 12.2396
                const width = (data.horseStamina / 100) * maxWidth
                $(".horse-stamina .line").css("width", width + "vw")
            }
            if (data.horseSpeed !== undefined && isOnHorse) {
                $(".current-speed").text(data.horseSpeed)
            }
            if (data.temperature !== undefined) {
                const temp = data.temperature
                const normalizedTemp = Math.max(0, Math.min(100, ((temp + 20) / 60) * 100))
                $(".temparature .circle").css("--p", normalizedTemp)
                $(".temparature-group .celius-text").text(temp)
                $(".weather-group .celius-text").text(temp)

                if (temp < 8) {
                    $(".temparature-icon").css("background-image", "url('./img/snow.png')")
                } else {
                    $(".temparature-icon").css("background-image", "url('./img/temp_icon.png')")
                }
            }
            if (data.time !== undefined) {
                $(".time .details-text").first().text(data.time)
            }
            if (data.date !== undefined) {
                $(".date .details-text").text(data.date)
            }
            if (data.weather !== undefined) {
                $(".weather-group .weather .details-text").text(data.weather.toUpperCase())
            }
            if (data.playerId !== undefined) {
                $(".details-group .time:last .details-text").text(data.playerId.toString().padStart(5, '0'))
            }
            if (data.money !== undefined) {
                $(".money .details-text").text("$" + data.money.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }))
            }
            if (data.isArmed !== undefined) {
                if (data.isArmed) {
                    // Don't show/hide weapon in edit mode, but update data
                    // Also check if visibility toggle is enabled and not server-disabled
                    if (!isEditMode && !serverDisabledElements['.weapon-hud-group']) {
                        const $rightWeaponCheckbox = $('.hud-settings-checkbox[data-element=".weapon-hud-group"]')
                        const isRightWeaponVisible = !$rightWeaponCheckbox.hasClass('off')
                        if (isRightWeaponVisible) {
                            $(".weapon-hud-group").fadeIn(300)
                        }
                    }

                    if (data.weaponName !== undefined) {
                        $(".weapon-name").text(data.weaponName)
                    }
                    if (data.weaponIcon !== undefined) {
                        $("#weapon-icon-img").attr("src", "./img/weapons/" + data.weaponIcon)
                    }
                    if (data.currentAmmo !== undefined) {
                        $(".current-ammo").text(data.currentAmmo)
                    }
                    if (data.maxAmmo !== undefined) {
                        $(".max-ammo").text(data.maxAmmo)
                    }
                } else {
                    // Don't hide weapon in edit mode
                    if (!isEditMode) {
                        $(".weapon-hud-group").fadeOut(300)
                    }
                }
            }

            // Handle secondary weapon (dual wield / left hand)
            if (data.isArmedSecondary !== undefined) {
                // Hide if unarmed or not armed
                const isSecondaryUnarmed = data.isSecondaryUnarmed === true

                if (data.isArmedSecondary && !isSecondaryUnarmed) {
                    // Show secondary weapon only if visibility toggle is enabled and not server-disabled
                    if (!isEditMode && !serverDisabledElements['.weapon-hud-group-secondary']) {
                        const $leftWeaponCheckbox = $('.hud-settings-checkbox[data-element=".weapon-hud-group-secondary"]')
                        const isLeftWeaponVisible = !$leftWeaponCheckbox.hasClass('off')
                        if (isLeftWeaponVisible) {
                            $(".weapon-hud-group-secondary").fadeIn(300)
                        }
                    }

                    if (data.weaponNameSecondary !== undefined) {
                        $(".weapon-name-secondary").text(data.weaponNameSecondary)
                    }
                    if (data.weaponIconSecondary !== undefined) {
                        $("#weapon-icon-img-secondary").attr("src", "./img/weapons/" + data.weaponIconSecondary)
                    }
                    if (data.currentAmmoSecondary !== undefined) {
                        $(".current-ammo-secondary").text(data.currentAmmoSecondary)
                    }
                    if (data.maxAmmoSecondary !== undefined) {
                        $(".max-ammo-secondary").text(data.maxAmmoSecondary)
                    }
                } else {
                    // Hide secondary weapon when not dual wielding or when unarmed
                    if (!isEditMode) {
                        $(".weapon-hud-group-secondary").fadeOut(300)
                    }
                }
            }
        }

        if (data.action == "add-status") {
            if ($("#status-" + data.id).length === 0) {
                const statusHtml = `
                <div class="custom-status hud-draggable" id="status-${data.id}" style="background-image: url('./img/circle_bg.png'); background-size: 100% 100%; width: 2.6042vw; height: 2.6042vw; display: flex; align-items: center; justify-content: center; z-index: 10;">
                    <div class="custom-status-icon" style="position: absolute; background-image: url('${data.icon}'); background-size: 100% 100%; width: 1.25vw; height: 1.25vw; background-position: center; background-repeat: no-repeat;"></div>
                    <div class="stroke" style="background-image: url('./img/circle_stroke.png'); background-size: 100% 100%; width: 2.6042vw; height: 2.6042vw;">
                        <div class="circle-group" style="background-size: 100% 100%; width: 2.6042vw; height: 2.6042vw; -webkit-mask-image: url('./img/circle_mask.png'); mask-image: url('./img/circle_mask.png'); -webkit-mask-size: 100% 100%; mask-size: 100% 100%; display: flex; align-items: center; justify-content: center;">
                            <div class="circle" style="--p: 0;"></div>
                        </div>
                    </div>
                </div>`;
                $(".hud-group").append(statusHtml);
                
                let savedColor = (hudConfig.colors && hudConfig.colors["status-"+data.id+"-color"]) ? hudConfig.colors["status-"+data.id+"-color"] : (themeColors[serverTheme] || themeColors['default']);
                $(`#status-${data.id} .circle`).css('background', `conic-gradient(${savedColor} calc(var(--p) * 3.6deg), transparent 0)`);
                
                if (hudConfig.scales && hudConfig.scales[`#status-${data.id}`]) {
                    const scale = hudConfig.scales[`#status-${data.id}`];
                    $(`#status-${data.id}`).css('transform', `scale(${scale})`);
                }
                
                if (hudConfig.customPositions) {
                    let hasSavedLayout = false;
                    if (hudConfig.layouts && hudConfig.layouts[hudConfig.currentLayout]) {
                        const savedPos = hudConfig.layouts[hudConfig.currentLayout][`#status-${data.id}`];
                        if (savedPos) {
                            $(`#status-${data.id}`).css({
                                position: savedPos.position || 'fixed',
                                left: savedPos.left,
                                top: savedPos.top,
                                marginLeft: savedPos.marginLeft || '0',
                                marginTop: savedPos.marginTop || '0',
                                transform: savedPos.transform || 'none'
                            });
                            // If scale exists in config, apply it to the transform as well safely
                            if (hudConfig.scales && hudConfig.scales[`#status-${data.id}`]) {
                                const scale = hudConfig.scales[`#status-${data.id}`];
                                $(`#status-${data.id}`).css('transform', `${savedPos.transform || 'none'} scale(${scale})`.replace('none ', ''));
                            }
                            hasSavedLayout = true;
                        }
                    }
                    
                    if (!hasSavedLayout) {
                        let lastElement = $('.custom-status').not(`#status-${data.id}`).last();
                        if (lastElement.length === 0 || lastElement.css('position') !== 'fixed') {
                            lastElement = $('.toilet'); 
                        }
                        
                        if (lastElement.length > 0 && lastElement.css('position') === 'fixed') {
                            let lastLeft = parseFloat(lastElement.css('left')) || 0;
                            let lastTop = parseFloat(lastElement.css('top')) || 0;
                            let gapPx = window.innerWidth * 0.005208; // 0.5208vw in pixels
                            let newLeft = lastLeft + lastElement.outerWidth() + gapPx;
                            
                            $(`#status-${data.id}`).css({
                                position: 'fixed',
                                left: newLeft + 'px',
                                top: lastTop + 'px',
                                margin: 0
                            });
                        }
                    }
                }
                
                // Add to HUD menu
                if ($(`.category-item[data-category="custom-${data.id}"]`).length === 0) {
                    const categoryHtml = `
                    <div class="category-item" data-category="custom-${data.id}">
                        <div class="category-icon" style="background-image: url('${data.icon}'); background-size: contain; background-repeat: no-repeat; background-position: center; width: 14px; height: 14px;"></div>
                        <div class="category-name">${data.id.charAt(0).toUpperCase() + data.id.slice(1)}</div>
                    </div>`;
                    $('.category').append(categoryHtml);

                    const scaleValue = (hudConfig.scales && hudConfig.scales[`#status-${data.id}`]) ? hudConfig.scales[`#status-${data.id}`] : 1.0;
                    
                    const pageHtml = `
                    <div class="hud-page" data-page="custom-${data.id}">
                        <div class="hud-visibility-checkbox">
                            <div class="hud-visibility-text">Visibility</div>
                            <div class="hud-settings-checkbox" data-element="#status-${data.id}">ON<div class="checkbox-dot"></div></div>
                        </div>
                        <div class="size-set">
                            <div class="size-header-grp">
                                <div>
                                    <div class="size-text">Size</div>
                                    <div class="size-desc">Adjust display size.</div>
                                </div>
                                <div class="size-value">${scaleValue.toFixed(1)}</div>
                            </div>
                            <div class="size-slider" data-element="#status-${data.id}" data-min="0.5" data-max="2" data-default="1">
                                <div class="size-slider-track">
                                    <div class="size-slider-fill"></div>
                                    <div class="size-slider-thumb"></div>
                                </div>
                            </div>
                        </div>
                        <div class="color-picker-wrapper">
                            <div class="color-picker-text"></div>
                            <div class="color-picker-preview">
                                <span class="color-code">${savedColor}</span>
                                <input type="color" class="color-input color-picker-input" data-target="status-${data.id}-color" value="${savedColor}">
                                <div class="color-square" style="background-color: ${savedColor};"></div>
                            </div>
                        </div>
                    </div>`;
                    $('.hud-middle-group-2').append(pageHtml);

                    // Re-calculate slider visual based on current scale
                    const $mSlider = $(`.hud-page[data-page="custom-${data.id}"] .size-slider`);
                    if ($mSlider.length) {
                        const min = 0.5, max = 2, range = max - min;
                        const percentage = Math.max(0, Math.min(100, ((scaleValue - min) / range) * 100));
                        $mSlider.find('.size-slider-fill').css('width', percentage + '%');
                        $mSlider.find('.size-slider-thumb').css('left', percentage + '%');
                    }

                    // Attach color change logic
                    $(`.color-input[data-target="status-${data.id}-color"]`).on('input', function(e) {
                        const newColor = $(this).val();
                        $(this).siblings(".color-code").text(newColor);
                        $(this).siblings(".color-square").css("background-color", newColor);
                        $(`#status-${data.id} .circle`).css("background", `conic-gradient(${newColor} calc(var(--p) * 3.6deg), transparent 0)`);
                        hudConfig.colors = hudConfig.colors || {};
                        hudConfig.colors["status-"+data.id+"-color"] = newColor;
                        saveHUDConfig();
                    });
                }
            } else {
                $(`#status-${data.id} .custom-status-icon`).css("background-image", `url('${data.icon}')`);
            }
        }

        if (data.action == "set-status") {
            if ($("#status-" + data.id).length > 0) {
                $(`#status-${data.id} .circle`).css("--p", data.value);
            }
        }

        if (data.action == "remove-status") {
            $("#status-" + data.id).remove();
            $(`.category-item[data-category="custom-${data.id}"]`).remove();
            $(`.hud-page[data-page="custom-${data.id}"]`).remove();
        }

    })
})

function initializeVoiceWaveform() {
    const soundsContainer = $(".sounds")
    soundsContainer.empty()

    // Create waveform bars
    for (let i = 0; i < VOICE_BAR_COUNT; i++) {
        const bar = $('<div class="voice-bar"></div>')
        soundsContainer.append(bar)

        // Store reference with initial height
        voiceBars.push({
            element: bar,
            currentHeight: 50, // percentage
            targetHeight: 50,
            velocity: 5
        })
    }
}

function startVoiceAnimation() {
    if (voiceAnimationInterval) return

    // Set initial active state
    $(".sounds").addClass("talking")

    // Show voice element if Talk Only mode is enabled
    if (hudConfig.voiceTalkOnly) {
        $('.voice').fadeIn(250)
    }

    // Animate voice bars with physics-based smooth movement
    voiceAnimationInterval = setInterval(() => {
        voiceBars.forEach((bar, index) => {
            // Generate new target height with varying intensities
            // Middle bars tend to be taller, edges shorter (classic waveform pattern)
            const distanceFromCenter = Math.abs(index - VOICE_BAR_COUNT / 2) / (VOICE_BAR_COUNT / 2)
            const baseIntensity = (1 - distanceFromCenter * 0.5) // Center bars more active

            // Random target between 10% and 90% based on position
            const minHeight = 10 + distanceFromCenter * 20
            const maxHeight = 90 - distanceFromCenter * 30
            bar.targetHeight = minHeight + Math.random() * (maxHeight - minHeight) * baseIntensity

            // Smooth spring physics for natural movement
            const difference = bar.targetHeight - bar.currentHeight
            bar.velocity += difference * 0.3 // Spring force
            bar.velocity *= 0.7 // Damping
            bar.currentHeight += bar.velocity

            // Update bar height
            bar.element.css('height', bar.currentHeight + '%')
        })
    }, 80) // Update every 80ms for smooth animation
}

function stopVoiceAnimation() {
    if (voiceAnimationInterval) {
        clearInterval(voiceAnimationInterval)
        voiceAnimationInterval = null
    }

    // Remove active state
    $(".sounds").removeClass("talking")

    // Hide voice element if Talk Only mode is enabled
    if (hudConfig.voiceTalkOnly) {
        $('.voice').fadeOut(250)
    }

    // Smoothly reset all bars to idle state
    const resetInterval = setInterval(() => {
        let allReset = true

        voiceBars.forEach((bar) => {
            const idleHeight = 20 // 20% idle height
            const difference = idleHeight - bar.currentHeight

            if (Math.abs(difference) > 0.5) {
                allReset = false
                bar.velocity += difference * 0.2
                bar.velocity *= 0.8
                bar.currentHeight += bar.velocity
                bar.element.css('height', bar.currentHeight + '%')
            } else {
                bar.currentHeight = idleHeight
                bar.velocity = 0
                bar.element.css('height', idleHeight + '%')
            }
        })

        if (allReset) {
            clearInterval(resetInterval)
        }
    }, 50)
}

// ==================== HUD EDITOR SYSTEM ====================

// Snap to grid
function snapToGrid(value) {
    return Math.round(value / GRID_SIZE) * GRID_SIZE
}

// ==================== COMPASS SYSTEM ====================

let currentHeading = 0;      // The current visually displayed heading
let targetHeading = 0;       // The latest heading received from the game
let isCompassAnimating = false; // Flag to track if the loop is running

function initializeCompass() {
    const strip = $('#compass-strip')
    strip.empty()

    // We create a repeating pattern of 0-359 degrees.
    let html = '';

    for (let set = 0; set < 3; set++) {
        for (let i = 0; i < 360; i += 15) {
            html += createCompassItem(i);
        }
    }

    strip.html(html);

    // Start the smooth animation loop
    if (!isCompassAnimating) {
        requestAnimationFrame(renderCompassLoop);
        isCompassAnimating = true;
    }
}

function createCompassItem(degrees) {
    let label = degrees;
    let isCardinal = false;

    if (degrees === 0 || degrees === 360) { label = "N"; isCardinal = true; }
    else if (degrees === 45) { label = "NE"; isCardinal = true; }
    else if (degrees === 90) { label = "E"; isCardinal = true; }
    else if (degrees === 135) { label = "SE"; isCardinal = true; }
    else if (degrees === 180) { label = "S"; isCardinal = true; }
    else if (degrees === 225) { label = "SW"; isCardinal = true; }
    else if (degrees === 270) { label = "W"; isCardinal = true; }
    else if (degrees === 315) { label = "NW"; isCardinal = true; }

    const cardinalClass = isCardinal ? 'cardinal' : '';

    return `
        <div class="compass-item">
            <div class="compass-item-text ${cardinalClass}">${label}</div>
            <div class="compass-item-line"></div>
        </div>
    `;
}

// Called by NUI message (e.g. every 50ms or 100ms)
function updateCompassUI(heading) {
    if (heading === undefined || heading === null) return
    targetHeading = heading;
}

// Shortest path interpolation for degrees (0-360 wrapping)
function lerpAngle(start, end, factor) {
    let diff = end - start;

    // Handle wrapping (finding shortest path)
    // If diff is > 180 (e.g. 350 to 10), go the other way
    if (diff > 180) {
        diff -= 360;
    } else if (diff < -180) {
        diff += 360;
    }

    return start + diff * factor;
}

function renderCompassLoop() {
    // Determine interpolation speed.
    // 0.1 is smooth, 0.2 is snappier.
    // Since updates might be slow (50ms+), a lower factor smooths out the "steps".
    const smoothFactor = 0.15;

    // Smoothly step 'currentHeading' towards 'targetHeading'
    currentHeading = lerpAngle(currentHeading, targetHeading, smoothFactor);

    // Normalize currentHeading within 0-360 for cleanliness logic (optional, but good for math stability over time)
    if (currentHeading < 0) currentHeading += 360;
    if (currentHeading >= 360) currentHeading -= 360;

    // --- VISUAL RENDER LOGIC ---
    // If Compass is hidden via settings, we can skip the heavy visual updates or leave them running.
    // Leaving them running is safer to avoid state desync when toggled back on, 
    // unless performance is critical. Given it is just a transform, it is cheap.

    // Configuration relative to CSS
    const unitWidthVW = 5.3438;
    const degreesPerUnit = 15;
    const vwPerDegree = unitWidthVW / degreesPerUnit;

    // One full set width (0-360)
    const fullSetWidthVW = 360 * vwPerDegree;

    // Center point correction
    const textCenterOffset = 1.5;

    // The visual shift calc
    // We target Set 1 (the middle set).
    const shift = fullSetWidthVW + (currentHeading * vwPerDegree) + textCenterOffset;

    // Apply transform
    $('#compass-strip').css('transform', `translateX(-${shift}vw)`);

    // Continue loop
    requestAnimationFrame(renderCompassLoop);
}

// HARDCODED DEFAULT POSITIONS (Legacy - removed, now using server layouts from config.lua)
const HARDCODED_DEFAULTS = {}

// Save default positions from server layouts
function saveDefaultPositions() {
    if (serverLayouts && serverLayouts[hudConfig.currentLayout]) {
        defaultPositions = { ...serverLayouts[hudConfig.currentLayout] }
    } else {
        defaultPositions = {}
    }
}

// Load HUD config from localStorage
function loadHUDConfig() {
    const saved = localStorage.getItem('vhud_config')
    if (saved) {
        try {
            const loadedConfig = JSON.parse(saved)
            // Merge with defaults to ensure all properties exist
            hudConfig = {
                ...hudConfig,
                ...loadedConfig,
                colors: {
                    ...hudConfig.colors,
                    ...(loadedConfig.colors || {})
                },
                scales: {
                    ...hudConfig.scales,
                    ...(loadedConfig.scales || {})
                },
                visibilities: {
                    ...hudConfig.visibilities,
                    ...(loadedConfig.visibilities || {})
                }
            }
            // Sync GRID_SIZE global variable with loaded config
            GRID_SIZE = (hudConfig.gridSize || 1.0) * 10
            // Store original saved values for cancel functionality
            savedGridSize = hudConfig.gridSize || 1.0
            savedHudVisibility = hudConfig.hudVisibility !== false
            console.log('[v-hud] Loaded config, scales:', hudConfig.scales)
        } catch (e) {
            console.error('[v-hud] Failed to load config:', e)
        }
    }
}

// Apply saved visibility states to HUD elements
function applySavedVisibilities() {
    if (!hudConfig.visibilities) return

    for (const selector in hudConfig.visibilities) {
        // Skip elements disabled by server config (Config.HUDElements)
        if (serverDisabledElements[selector]) continue

        const isVisible = hudConfig.visibilities[selector]
        const $checkbox = $(`.hud-settings-checkbox[data-element="${selector}"]`)

        if (isVisible === false) {
            // Hide element and update checkbox state
            $(selector).hide()
            $checkbox.addClass('off')
            $checkbox.contents().filter(function () {
                return this.nodeType === 3
            }).remove()
            $checkbox.prepend(_L('toggle_off') || 'OFF')
        } else {
            // Show element and update checkbox state
            $(selector).show()
            $checkbox.removeClass('off')
            $checkbox.contents().filter(function () {
                return this.nodeType === 3
            }).remove()
            $checkbox.prepend(_L('toggle_on') || 'ON')
        }
    }
}

// Save HUD config to localStorage
function saveHUDConfig() {
    localStorage.setItem('vhud_config', JSON.stringify(hudConfig))
}

// Export HUD config as JSON
function exportHUDConfig() {
    const dataStr = JSON.stringify(hudConfig, null, 2)
    const dataBlob = new Blob([dataStr], { type: 'application/json' })
    const url = URL.createObjectURL(dataBlob)
    const link = document.createElement('a')
    link.href = url
    link.download = 'vhud_config.json'
    link.click()
    URL.revokeObjectURL(url)
}

// Import HUD config from JSON
function importHUDConfig(jsonString) {
    try {
        const imported = JSON.parse(jsonString)
        hudConfig = imported
        saveHUDConfig()
        applyLayout(hudConfig.currentLayout)
    } catch (e) {
        console.error('Failed to import HUD config:', e)
    }
}

// Get all draggable HUD elements
function getDraggableElements() {
    let elements = [
        // Details group items (individually draggable)
        '.details-group > .time:first',  // Time
        '.details-group > .date',         // Date
        '.details-group > .weather-group', // Weather
        '.details-group > .time:last',    // Player ID
        '.details-group > .money',        // Money
        // Main HUD elements
        '.weapon-hud-group',
        '.weapon-hud-group-secondary', // Added
        '.compass',                    // Added
        '.horse-hud-group',
        '.horse-health',
        '.horse-durabilty',
        '.temparature-group',
        '.voice', // Voice indicator
        // Individual circles (direct children of hud-group)
        '.health',
        '.stamina',
        '.hunger',
        '.water',
        '.brain',
        '.bath',
        '.toilet'
    ]

    $('.custom-status').each(function() {
        if (this.id) {
            elements.push('#' + this.id);
        }
    });

    return elements;
}

// Save current positions
function saveCurrentPositions() {
    originalPositions = {}
    getDraggableElements().forEach(selector => {
        const $el = $(selector)
        if ($el.length) {
            originalPositions[selector] = {
                position: $el.css('position'),
                left: $el.css('left'),
                top: $el.css('top'),
                marginLeft: $el.css('margin-left'),
                marginTop: $el.css('margin-top'),
                transform: $el.css('transform')
            }
        }
    })
}

// Restore original positions
function restoreOriginalPositions() {
    Object.keys(originalPositions).forEach(selector => {
        const $el = $(selector)
        const pos = originalPositions[selector]
        if ($el.length && pos) {
            $el.css({
                position: pos.position,
                left: pos.left,
                top: pos.top,
                marginLeft: pos.marginLeft,
                marginTop: pos.marginTop,
                transform: pos.transform
            })
            $el.removeClass('hud-draggable')
        }
    })
}

// Apply layout from config (only if exists)
function applyLayout(layoutName) {
    // Try to get layout from user's saved custom positions first
    let layout = hudConfig.layouts[layoutName]

    // If no custom layout, use server layouts or default positions
    if (!layout || Object.keys(layout).length === 0) {
        if (serverLayouts && serverLayouts[layoutName]) {
            layout = serverLayouts[layoutName]
        } else if (defaultPositions && Object.keys(defaultPositions).length > 0) {
            layout = defaultPositions
        } else {
            return
        }
    }

    // Apply the layout positions
    Object.keys(layout).forEach(selector => {
        const $el = $(selector)
        const pos = layout[selector]
        if ($el.length && pos) {
            $el.css({
                position: pos.position || 'fixed',
                left: pos.left,
                top: pos.top,
                marginLeft: pos.marginLeft || '0',
                marginTop: pos.marginTop || '0',
                transform: pos.transform || 'none'
            })
        }
    })

    // Update layout button states after applying layout
    setTimeout(() => updateLayoutButtons(), 100)
}

// Apply imported layout from JSON
function applyImportedLayout(layout) {

    // Apply the layout positions
    Object.keys(layout).forEach(selector => {
        const $el = $(selector)
        const pos = layout[selector]
        if ($el.length && pos) {
            $el.css({
                position: pos.position || 'fixed',
                left: pos.left,
                top: pos.top,
                marginLeft: pos.marginLeft || '0',
                marginTop: pos.marginTop || '0',
                transform: pos.transform || 'none'
            })
        }
    })

}

// Reset to default positions
function resetToDefault() {

    // Clear custom positions flag
    hudConfig.customPositions = false

    // Clear current layout
    hudConfig.layouts[hudConfig.currentLayout] = {}

    // Apply default positions
    Object.keys(defaultPositions).forEach(selector => {
        const $el = $(selector)
        const pos = defaultPositions[selector]
        if ($el.length && pos) {
            $el.css({
                position: pos.position,
                left: pos.left,
                top: pos.top,
                marginLeft: pos.marginLeft,
                marginTop: pos.marginTop,
                transform: pos.transform
            })
        }
    })

    // Save config
    saveHUDConfig()

    // Update layout button states after reset
    setTimeout(() => updateLayoutButtons(), 100)
}

// Save current layout positions
function saveCurrentLayout() {
    const layout = {}
    getDraggableElements().forEach(selector => {
        const $el = $(selector)
        if ($el.length) {
            layout[selector] = {
                position: $el.css('position'),
                left: $el.css('left'),
                top: $el.css('top'),
                marginLeft: $el.css('margin-left'),
                marginTop: $el.css('margin-top'),
                transform: $el.css('transform')
            }
        }
    })
    hudConfig.layouts[hudConfig.currentLayout] = layout
    hudConfig.customPositions = true
}

// Check if element is at default position
function isDefaultPosition(selector) {
    if (!originalPositions[selector]) return true

    const $el = $(selector)
    const original = originalPositions[selector]
    const current = {
        left: $el.css('left'),
        top: $el.css('top'),
        marginLeft: $el.css('margin-left'),
        marginTop: $el.css('margin-top')
    }

    return (original.left === current.left &&
        original.top === current.top &&
        original.marginLeft === current.marginLeft &&
        original.marginTop === current.marginTop)
}

// Enable edit mode
function enableEditMode() {
    isEditMode = true
    saveCurrentPositions()

    // Add edit-mode class to body
    $('body').addClass('edit-mode')

    // Close HUD settings menu
    $('.hud-menu-container').removeClass('show')

    // Show horse and weapon elements for editing (temporarily, unless server-disabled)
    if (!serverDisabledElements['.horse-hud-group']) $('.horse-hud-group').css('visibility', 'visible')
    if (!serverDisabledElements['.horse-health']) $('.horse-health').css('visibility', 'visible')
    if (!serverDisabledElements['.horse-durabilty']) $('.horse-durabilty').css('visibility', 'visible')
    if (!serverDisabledElements['.weapon-hud-group']) $('.weapon-hud-group').css({ 'display': 'flex', 'visibility': 'visible' })
    if (!serverDisabledElements['.weapon-hud-group-secondary']) $('.weapon-hud-group-secondary').css({ 'display': 'flex', 'visibility': 'visible' })

    // Force browser reflow to ensure elements are visible before getting offset
    void $('.weapon-hud-group')[0].offsetHeight

    // Make elements draggable
    getDraggableElements().forEach(selector => {
        const $el = $(selector)
        if ($el.length) {

            $el.each(function () {
                const element = $(this)
                element.addClass('hud-draggable')

                // Get current offset position (where it currently is on screen)
                const offset = element.offset()

                // Check if element is actually visible

                // Set position to fixed (viewport-relative) and use offset coordinates
                // This ensures offset values work correctly regardless of parent positioning
                element.css({
                    'position': 'fixed',
                    'left': offset.left + 'px',
                    'top': offset.top + 'px',
                    'margin': 0,
                    'z-index': 10001
                })
            })
        } else {
            console.warn('Element not found:', selector)
        }
    })

}

// Disable edit mode
function disableEditMode(save = true) {
    isEditMode = false

    // Save or restore positions (temporary, not persisted until Save button)
    if (save) {
        saveCurrentLayout()
    } else {
        restoreOriginalPositions()
    }

    // Remove edit-mode class from body
    $('body').removeClass('edit-mode')

    // Remove draggable class
    $('.hud-draggable').removeClass('hud-draggable')

    // Hide horse elements if not on horse (skip server-disabled ones)
    if (!isOnHorse) {
        if (!serverDisabledElements['.horse-hud-group']) $('.horse-hud-group').css('visibility', 'hidden')
        if (!serverDisabledElements['.horse-health']) $('.horse-health').css('visibility', 'hidden')
        if (!serverDisabledElements['.horse-durabilty']) $('.horse-durabilty').css('visibility', 'hidden')
    }

    // Hide weapon if not armed
    if (!serverDisabledElements['.weapon-hud-group']) $('.weapon-hud-group').css('display', 'none')

    // Close HUD menu
    $.post("https://v-hud/closeHudMenu", JSON.stringify({}))
}

// Drag start
function onDragStart(e) {
    if (!isEditMode) return

    const $target = $(e.target).closest('.hud-draggable')
    if (!$target.length) return

    currentDraggable = $target
    currentDraggable.addClass('dragging')

    // Get current position
    const currentLeft = parseFloat(currentDraggable.css('left')) || 0
    const currentTop = parseFloat(currentDraggable.css('top')) || 0

    // Calculate offset - difference between mouse and element's current position
    dragOffset.x = e.clientX - currentLeft
    dragOffset.y = e.clientY - currentTop

    e.preventDefault()
}

// Drag move
function onDragMove(e) {
    if (!currentDraggable) return

    let newX = e.clientX - dragOffset.x
    let newY = e.clientY - dragOffset.y

    // Snap to grid
    newX = snapToGrid(newX)
    newY = snapToGrid(newY)

    // Boundary checking
    const elWidth = currentDraggable.outerWidth()
    const elHeight = currentDraggable.outerHeight()
    const maxX = window.innerWidth - elWidth
    const maxY = window.innerHeight - elHeight

    const boundedX = Math.max(0, Math.min(newX, maxX))
    const boundedY = Math.max(0, Math.min(newY, maxY))

    currentDraggable.css({
        left: boundedX + 'px',
        top: boundedY + 'px'
    })

    e.preventDefault()
}


// Drag end
function onDragEnd(e) {
    if (currentDraggable) {
        currentDraggable.removeClass('dragging')
        currentDraggable = null
    }
}

// Export current HUD layout as JSON
function exportCurrentLayout() {
    const layout = {}

    getDraggableElements().forEach(selector => {
        const $el = $(selector)
        if ($el.length) {
            const offset = $el.offset()
            const computed = {
                position: $el.css('position'),
                left: offset.left + 'px',
                top: offset.top + 'px',
                marginLeft: $el.css('margin-left'),
                marginTop: $el.css('margin-top'),
                transform: $el.css('transform'),
                width: $el.outerWidth() + 'px',
                height: $el.outerHeight() + 'px'
            }
            layout[selector] = computed
        }
    })

    const exportData = {
        version: "1.0",
        exported: new Date().toISOString(),
        layout: layout
    }

    return exportData
}

// Copy HUD layout JSON to clipboard
function copyLayoutJSON() {
    const data = exportCurrentLayout()
    const jsonStr = JSON.stringify(data, null, 2)

    navigator.clipboard.writeText(jsonStr).then(() => {

    }).catch(err => {
    })
}

// Detect which layout matches current positions
function detectActiveLayout() {
    if (!serverLayouts) return null

    // Helper to convert VW to PX (1920px = 100vw)
    const vwToPx = (vw) => {
        const numericVw = parseFloat(vw)
        return (numericVw * window.innerWidth) / 100
    }

    // Get current positions of all elements (in PX)
    const currentPositions = {}
    getDraggableElements().forEach(selector => {
        const $el = $(selector)
        if ($el.length) {
            currentPositions[selector] = {
                left: parseFloat($el.css('left')),
                top: parseFloat($el.css('top'))
            }
        }
    })

    // Compare with each server layout
    const layoutNames = ['standart', 'normal', 'story']
    for (const layoutName of layoutNames) {
        const layout = serverLayouts[layoutName]
        if (!layout || Object.keys(layout).length === 0) continue

        let matches = true
        let matchCount = 0
        let totalElements = 0

        // Check if all positions match (with small tolerance for rounding)
        for (const selector in layout) {
            totalElements++
            const current = currentPositions[selector]
            const expected = layout[selector]

            if (!current || !expected) {
                continue // Skip missing elements
            }

            // Convert expected VW values to PX for comparison
            const expectedLeft = vwToPx(expected.left)
            const expectedTop = vwToPx(expected.top)

            // Compare positions (allow 2px tolerance for rounding)
            if (Math.abs(current.left - expectedLeft) <= 2 && Math.abs(current.top - expectedTop) <= 2) {
                matchCount++
            }
        }

        // If at least 80% of elements match, consider it the active layout
        if (totalElements > 0 && matchCount / totalElements >= 0.8) {
            return layoutName
        }
    }

    return null // Custom positions, no match
}

// Update layout button active states
function updateLayoutButtons() {
    const activeLayout = detectActiveLayout()

    // Remove all active states first
    $('.layout-button').removeClass('active')

    if (activeLayout) {
        // Activate the matching layout button (CSS will apply theme filter automatically)
        $(`.layout-button[data-layout="${activeLayout}"]`).addClass('active')
    }
}


// Initialize HUD Editor
$(document).ready(function () {
    // Load saved config from localStorage
    loadHUDConfig()

    // Layout button click (General Layouts - Standart/Normal/Story)
    $(document).on('click', '.layout-button', function () {
        const layoutName = $(this).data('layout')

        // Switch layout (temporary - will be saved only on Save button click)
        if (serverLayouts && serverLayouts[layoutName]) {
            // Store pending layout change for save
            hudConfig.pendingLayout = layoutName

            // Apply the new layout visually (temporary)
            applyLayout(layoutName)

        }
    })

    // Edit button click
    $(document).on('click', '.edit-btn', function () {
        if (!isEditMode) {
            enableEditMode()
        }
    })

    // Reset button click
    $(document).on('click', '.reset-btn', function () {
        resetToDefault()

        // Reset all colors to server theme
        const defaultColors = {
            'voice-color': defaultThemeColor,
            health: defaultThemeColor,
            stamina: defaultThemeColor,
            water: defaultThemeColor,
            hunger: defaultThemeColor,
            brain: defaultThemeColor,
            bath: defaultThemeColor,
            toilet: defaultThemeColor,
            'horse-health': defaultThemeColor,
            'horse-durabilty': defaultThemeColor,
            'temparature': defaultThemeColor,
            'details-time': defaultThemeColor,
            'details-date': defaultThemeColor,
            'details-weather': defaultThemeColor,
            'details-playerid': defaultThemeColor,
            'details-money': defaultThemeColor
        }

        const detailsTargetMapReset = {
            'details-time': '.details-group > .time:first',
            'details-date': '.details-group > .date',
            'details-weather': '.details-group > .weather-group',
            'details-playerid': '.details-group > .time:last',
            'details-money': '.details-group > .money'
        }

        // Reset colors in config
        hudConfig.colors = { ...defaultColors }

        // Apply default colors to UI and elements
        $('.color-picker-input').each(function () {
            const $input = $(this)
            const target = $input.data('target')
            const color = defaultColors[target] || defaultThemeColor

            // Update input value
            $input.prop('value', color)

            // Update preview
            const $wrapper = $input.closest('.color-picker-preview')
            $wrapper.find('.color-code').text(color)
            $wrapper.find('.color-square').css('background-color', color)

            // Handle details group colors (icon-bg + details-text)
            if (target.startsWith('details-')) {
                const selector = detailsTargetMapReset[target]
                if (selector) {
                    $(`${selector} .icon-bg`).css('background-color', color)
                    $(`${selector} .details-text`).css('color', color)
                    // Also update weather-celsius background for weather
                    if (target === 'details-weather') {
                        $(`${selector} .weather-celsius`).css('background-color', color)
                    }
                }
            } else if (target === 'voice-color') {
                // Apply color to voice icon and all voice bars
                $('.voice-icon-group').css('background-color', color)
                $('.sounds .voice-bar').css('background', color)
            } else {
                // Apply to element circle
                $(`.${target} .circle`).css('background', `conic-gradient(${color} calc(var(--p) * 3.6deg), transparent 0)`)
            }
        })

        // Reset all sliders to default (1.0)
        $('.size-slider[data-element]').each(function () {
            const $slider = $(this)
            const selector = $slider.data('element')

            // Reset element scale
            $(selector).css('transform', 'scale(1)')

            // Reset slider UI to 1.0 (33.33% position)
            $slider.find('.size-slider-fill').css('width', '33.33%')
            $slider.find('.size-slider-thumb').css('left', '33.33%')
            $slider.closest('.size-set').find('.size-value').text('1.0')
        })

        // Reset Grid Size to default (1.0)
        const $gridSlider = $('#grid-size-slider')
        if ($gridSlider.length) {
            GRID_SIZE = 10 // 1.0 * 10
            hudConfig.gridSize = 1.0

            $gridSlider.find('.size-slider-fill').css('width', '33.33%')
            $gridSlider.find('.size-slider-thumb').css('left', '33.33%')
            $gridSlider.closest('.size-set').find('.size-value').text('1.0')
        }

        // Clear scales from config
        hudConfig.scales = {}

        // Clear temporary values
        tempColors = {}
        tempScaleValues = {}

        // Re-apply server theme to override default colors
        applyServerTheme(serverTheme)

        // Save config
        saveHUDConfig()
    })

    // Copy settings button click - Exports ALL customizable settings
    $(document).on('click', '.copy-settings', function () {
        const exportData = {
            version: '2.0',
            positions: {},
            colors: {},
            scales: {},
            settings: {
                gridSize: hudConfig.gridSize || 1.0,
                cinematicMode: hudConfig.cinematicMode || false,
                gridSize: hudConfig.gridSize || 1.0,
                cinematicMode: hudConfig.cinematicMode || false,
                hudVisibility: hudConfig.hudVisibility !== false,
                compassVisibility: hudConfig.compassVisibility !== false,
                currentLayout: hudConfig.currentLayout || 'standart'
            }
        }

        // Helper function to convert PX to VW (base: 1920px = 100vw)
        const pxToVw = (px) => {
            const vw = (px * 100) / 1920
            return vw.toFixed(4) + 'vw'
        }

        // Get all element positions
        getDraggableElements().forEach(selector => {
            const $el = $(selector)
            if ($el.length) {
                const currentLeft = parseFloat($el.css('left')) || 0
                const currentTop = parseFloat($el.css('top')) || 0

                exportData.positions[selector] = {
                    position: 'fixed',
                    left: pxToVw(currentLeft),
                    top: pxToVw(currentTop),
                    marginLeft: '0vw',
                    marginTop: '0vw',
                    transform: 'none'
                }
            }
        })

        // Get all colors (merge saved colors with temporary unsaved changes)
        exportData.colors = { ...hudConfig.colors, ...tempColors }

        // Get all scales (merge saved scales with temporary unsaved changes)
        exportData.scales = { ...hudConfig.scales, ...tempScaleValues }

        // Convert to JSON string
        const jsonStr = JSON.stringify(exportData)

        // Copy to clipboard using textarea fallback method
        try {
            // Create temporary textarea
            const textarea = document.createElement('textarea')
            textarea.value = jsonStr
            textarea.style.position = 'fixed'
            textarea.style.left = '-9999px'
            textarea.style.top = '0'
            document.body.appendChild(textarea)

            // Select and copy
            textarea.focus()
            textarea.select()

            const successful = document.execCommand('copy')
            document.body.removeChild(textarea)

            if (successful) {
                $.post("https://v-hud/showNotification", JSON.stringify({
                    text: _L("layout_copied"),
                    type: "success"
                }))
            } else {
                throw new Error('execCommand failed')
            }
        } catch (err) {
            $.post("https://v-hud/showNotification", JSON.stringify({
                text: _L("copy_failed"),
                type: "error"
            }))
        }
    })

    // HUD Visibility Checkbox Toggle (for element-specific checkboxes only)
    $(document).on('click', '.hud-settings-checkbox', function (e) {
        const $checkbox = $(this)

        // Skip if this is a special checkbox with ID or specific class (handled by dedicated handlers)
        if ($checkbox.attr('id') === 'hud-visibility-checkbox' || $checkbox.attr('id') === 'compass-visibility-checkbox' || $checkbox.attr('id') || $checkbox.hasClass('voice-follow-head-checkbox') || $checkbox.hasClass('voice-talk-only-checkbox')) {
            return
        }

        // Ensure dot exists
        if ($checkbox.find('.checkbox-dot').length === 0) {
            $checkbox.append('<div class="checkbox-dot"></div>')
        }

        const elementSelector = $checkbox.data('element')
        const isCurrentlyOn = !$checkbox.hasClass('off')

        if (isCurrentlyOn) {
            // Turn OFF - change class for smooth dot slide
            $checkbox.addClass('off')

            // Change text without removing dot
            $checkbox.contents().filter(function () {
                return this.nodeType === 3; // Text nodes only
            }).remove()
            $checkbox.prepend(_L('toggle_off'))

            // Hide specific element with fade animation
            if (elementSelector) {
                $(elementSelector).fadeOut(300)
                // Store visibility state temporarily (will be saved on Save click)
                tempVisibilities[elementSelector] = false
            }
        } else {
            // Turn ON - change class for smooth dot slide
            $checkbox.removeClass('off')

            // Change text without removing dot
            $checkbox.contents().filter(function () {
                return this.nodeType === 3; // Text nodes only
            }).remove()
            $checkbox.prepend(_L('toggle_on'))

            // Show specific element with fade animation
            if (elementSelector) {
                $(elementSelector).fadeIn(300)
                // Store visibility state temporarily (will be saved on Save click)
                tempVisibilities[elementSelector] = true
            }
        }
    })

    // Mouse events for dragging
    $(document).on('mousedown', '.hud-draggable', onDragStart)
    $(document).on('mousemove', onDragMove)
    $(document).on('mouseup', onDragEnd)

    // Keyboard events
    $(document).keydown(function (e) {
        if (!isEditMode) return

        if (e.key === 'Enter') {
            disableEditMode(true) // Save
        } else if (e.key === 'Escape') {
            disableEditMode(false) // Cancel
        }
    })

    // Size Slider functionality
    let activeSlider = null
    let sliderStartX = 0

    $(document).on('mousedown', '.size-slider-thumb', function (e) {
        e.preventDefault()
        activeSlider = $(this).closest('.size-slider')
        sliderStartX = e.clientX

        // Add grabbing state
        $(this).addClass('grabbing')
    })

    $(document).on('mousemove', function (e) {
        if (!activeSlider) return

        const $slider = activeSlider
        const $track = $slider.find('.size-slider-track')
        const $fill = $slider.find('.size-slider-fill')
        const $thumb = $slider.find('.size-slider-thumb')
        const $valueDisplay = $slider.closest('.size-set').find('.size-value')

        // Get track position and dimensions
        const trackRect = $track[0].getBoundingClientRect()
        const trackWidth = trackRect.width

        // Calculate mouse position relative to track
        let mouseX = e.clientX - trackRect.left
        mouseX = Math.max(0, Math.min(mouseX, trackWidth))

        // Calculate percentage (0-100)
        const percentage = (mouseX / trackWidth) * 100

        // Get min, max, default values
        const min = parseFloat($slider.data('min')) || 0.5
        const max = parseFloat($slider.data('max')) || 2
        const range = max - min

        // Calculate actual value
        const value = min + (percentage / 100) * range
        const roundedValue = Math.round(value * 10) / 10

        // Update UI
        $fill.css('width', percentage + '%')
        $thumb.css('left', percentage + '%')
        $valueDisplay.text(roundedValue.toFixed(1))

        // Special handling for grid-size-slider
        if ($slider.attr('id') === 'grid-size-slider') {
            GRID_SIZE = roundedValue * 10
            hudConfig.gridSize = roundedValue
            tempScaleValues['__grid__'] = roundedValue // Track for save
            // Update CSS custom property for visual grid
            document.body.style.setProperty('--grid-size', GRID_SIZE + 'px')
        } else {
            // Apply scale to element (temporary)
            const elementSelector = $slider.data('element')
            if (elementSelector) {
                $(elementSelector).css('transform', `scale(${roundedValue})`)
                tempScaleValues[elementSelector] = roundedValue
            }
        }
    })

    if (activeSlider) {
        activeSlider.find('.size-slider-thumb').removeClass('grabbing')

        activeSlider = null
    }
    $(document).on('mouseup', function () {
        if (activeSlider) {
            activeSlider.find('.size-slider-thumb').removeClass('grabbing')
            activeSlider = null
        }
    })
})

// Compass Visibility Toggle Handler
$(document).on('click', '#compass-visibility-checkbox', function () {
    const $checkbox = $(this)

    // Ensure dot exists
    if ($checkbox.find('.checkbox-dot').length === 0) {
        $checkbox.append('<div class="checkbox-dot"></div>')
    }

    const isCurrentlyOn = !$checkbox.hasClass('off')

    if (isCurrentlyOn) {
        // Turn OFF
        $checkbox.addClass('off')
        $checkbox.contents().filter(function () { return this.nodeType === 3; }).remove() // Remove text
        $checkbox.prepend(_L('toggle_off'))

        hudConfig.compassVisibility = false
        $('.compass').fadeOut(300)
    } else {
        // Turn ON
        $checkbox.removeClass('off')
        $checkbox.contents().filter(function () { return this.nodeType === 3; }).remove() // Remove text
        $checkbox.prepend(_L('toggle_on'))

        hudConfig.compassVisibility = true
        $('.compass').fadeIn(300)
    }
})

// Click on track to jump
$(document).on('click', '.size-slider-track', function (e) {
    if ($(e.target).hasClass('size-slider-thumb')) return

    const $slider = $(this).closest('.size-slider')
    const $track = $(this)
    const $fill = $slider.find('.size-slider-fill')
    const $thumb = $slider.find('.size-slider-thumb')
    const $valueDisplay = $slider.closest('.size-set').find('.size-value')

    // Get track position and dimensions
    const trackRect = this.getBoundingClientRect()
    const trackWidth = trackRect.width

    // Calculate mouse position relative to track
    let mouseX = e.clientX - trackRect.left
    mouseX = Math.max(0, Math.min(mouseX, trackWidth))

    // Calculate percentage (0-100)
    const percentage = (mouseX / trackWidth) * 100

    // Get min, max values
    const min = parseFloat($slider.data('min')) || 0.5
    const max = parseFloat($slider.data('max')) || 2
    const range = max - min

    // Calculate actual value
    const value = min + (percentage / 100) * range
    const roundedValue = Math.round(value * 10) / 10

    // Update UI
    $fill.css('width', percentage + '%')
    $thumb.css('left', percentage + '%')
    $valueDisplay.text(roundedValue.toFixed(1))

    // Special handling for grid-size-slider
    if ($slider.attr('id') === 'grid-size-slider') {
        GRID_SIZE = roundedValue * 10
        hudConfig.gridSize = roundedValue
        tempScaleValues['__grid__'] = roundedValue // Track for save
        // Update CSS custom property for visual grid
        document.body.style.setProperty('--grid-size', GRID_SIZE + 'px')
    } else {
        // Apply scale to element (temporary, until Save is clicked)
        const elementSelector = $slider.data('element')
        if (elementSelector) {
            $(elementSelector).css('transform', `scale(${roundedValue})`)
            tempScaleValues[elementSelector] = roundedValue
        }
    }
})

// Save button - Save all temporary changes
$(document).on('click', '.save-btn', function () {
    // Finalize pending layout change
    if (hudConfig.pendingLayout) {
        hudConfig.currentLayout = hudConfig.pendingLayout
        hudConfig.customPositions = false
        hudConfig.layouts[hudConfig.pendingLayout] = {}
        if (serverLayouts && serverLayouts[hudConfig.pendingLayout]) {
            defaultPositions = { ...serverLayouts[hudConfig.pendingLayout] }
        }
        hudConfig.pendingLayout = null
    }

    // Save scale values to localStorage
    for (const selector in tempScaleValues) {
        if (selector === '__grid__') {
            // Grid size already saved in hudConfig.gridSize
            continue
        }
        if (!hudConfig.scales) hudConfig.scales = {}
        hudConfig.scales[selector] = tempScaleValues[selector]
        console.log('[v-hud] Saving scale:', selector, '=', tempScaleValues[selector])
    }
    console.log('[v-hud] All scales after save:', hudConfig.scales)

    // Save color values to localStorage
    for (const target in tempColors) {
        if (!hudConfig.colors) hudConfig.colors = {}
        hudConfig.colors[target] = tempColors[target]
    }

    // Save visibility values to localStorage
    for (const selector in tempVisibilities) {
        if (!hudConfig.visibilities) hudConfig.visibilities = {}
        hudConfig.visibilities[selector] = tempVisibilities[selector]
    }

    // Save layout positions if in edit mode
    if (isEditMode) {
        saveCurrentLayout()
    }

    // Save config
    saveHUDConfig()

    // Update saved values for cancel functionality
    savedHudVisibility = hudConfig.hudVisibility
    savedGridSize = hudConfig.gridSize

    // Clear temporary values
    tempScaleValues = {}
    tempColors = {}
    tempVisibilities = {}

    // Close menu and remove NUI focus
    $('.hud-menu-container').removeClass('show')
    $.post("https://v-hud/closeHudMenu", JSON.stringify({}))

    $.post("https://v-hud/showNotification", JSON.stringify({
        text: _L("settings_saved"),
        type: "success"
    }))
})

// Initialize Grid Size Slider from saved config
function initializeGridSize() {
    const gridValue = hudConfig.gridSize || 1.0
    GRID_SIZE = gridValue * 10

    const $slider = $('#grid-size-slider')
    if ($slider.length) {
        const min = 0.5
        const max = 2
        const range = max - min
        const percentage = ((gridValue - min) / range) * 100

        $slider.find('.size-slider-fill').css('width', percentage + '%')
        $slider.find('.size-slider-thumb').css('left', percentage + '%')
        $slider.closest('.size-set').find('.size-value').text(gridValue.toFixed(1))
    }

    // Update CSS custom property for visual grid
    document.body.style.setProperty('--grid-size', GRID_SIZE + 'px')
}

// Cinematic Mode Checkbox
$(document).on('click', '#cinematic-mode-checkbox', function (e) {
    e.stopPropagation()

    const $checkbox = $(this)

    // Ensure dot exists
    if ($checkbox.find('.checkbox-dot').length === 0) {
        $checkbox.append('<div class="checkbox-dot"></div>')
    }

    const isCurrentlyOn = !$checkbox.hasClass('off')

    if (isCurrentlyOn) {
        // Turn OFF - change class for smooth dot slide
        $checkbox.addClass('off')

        // Change text without removing dot
        $checkbox.contents().filter(function () {
            return this.nodeType === 3; // Text nodes only
        }).remove()
        $checkbox.prepend(_L('toggle_off'))

        // IMPORTANT: Before removing cinematic-mode class, ensure container visibility
        // is preserved based on hudVisibility setting to prevent flicker
        if (hudConfig.hudVisibility !== false) {
            $('.hud-main-container').css('display', 'flex')
        }

        $('body').removeClass('cinematic-mode')
        hudConfig.cinematicMode = false

        // Move menu back to hud-main-container if it was moved to body
        if ($('.hud-menu-container').parent().is('body') && hudConfig.hudVisibility !== false) {
            $('.hud-menu-container').appendTo('.hud-main-container')
        }

        $.post("https://v-hud/toggleCinematicMode", JSON.stringify({ enabled: false }))
    } else {
        // Turn ON - change class for smooth dot slide
        $checkbox.removeClass('off')

        // Change text without removing dot
        $checkbox.contents().filter(function () {
            return this.nodeType === 3; // Text nodes only
        }).remove()
        $checkbox.prepend(_L('toggle_on'))

        $('body').addClass('cinematic-mode')
        hudConfig.cinematicMode = true

        // Move menu to body so it's still accessible when HUD is hidden
        if (!$('.hud-menu-container').parent().is('body')) {
            $('.hud-menu-container').appendTo('body')
        }

        // Immediately hide HUD container for instant feedback
        $('.hud-main-container').fadeOut(250)

        $.post("https://v-hud/toggleCinematicMode", JSON.stringify({ enabled: true }))
    }

    saveHUDConfig()
})

// Hud Visibility Checkbox (General page)
$(document).on('click', '#hud-visibility-checkbox', function (e) {
    e.stopPropagation()

    const $checkbox = $(this)

    // Ensure dot exists
    if ($checkbox.find('.checkbox-dot').length === 0) {
        $checkbox.append('<div class="checkbox-dot"></div>')
    }

    const isCurrentlyOn = !$checkbox.hasClass('off')

    if (isCurrentlyOn) {
        // Turn OFF
        $checkbox.addClass('off')

        // Change text without removing dot
        $checkbox.contents().filter(function () {
            return this.nodeType === 3;
        }).remove()
        $checkbox.prepend(_L('toggle_off'))

        hudConfig.hudVisibility = false
        hudConfig.pendingHudVisibility = false

        $('.hud-main-container').fadeOut(200)
        $.post("https://v-hud/toggleHudVisibility", JSON.stringify({ visible: false }))

        if ($('.hud-menu-container').hasClass('show')) {
            $('.hud-menu-container').appendTo('body')
        }
    } else {
        // Turn ON
        $checkbox.removeClass('off')

        // Change text without removing dot
        $checkbox.contents().filter(function () {
            return this.nodeType === 3;
        }).remove()
        $checkbox.prepend(_L('toggle_on'))

        hudConfig.hudVisibility = true
        hudConfig.pendingHudVisibility = true

        $('.hud-main-container').show()

        if ($('.hud-menu-container').parent().is('body')) {
            $('.hud-menu-container').appendTo('.hud-main-container')
        }

        $.post("https://v-hud/toggleHudVisibility", JSON.stringify({ visible: true }))
    }

    // Don't auto-save - will be saved when Save button is clicked
})

// Voice Follow Head Checkbox
$(document).on('click', '.voice-follow-head-checkbox', function (e) {
    e.stopPropagation()

    const $checkbox = $(this)

    // Ensure dot exists
    if ($checkbox.find('.checkbox-dot').length === 0) {
        $checkbox.append('<div class="checkbox-dot"></div>')
    }

    const isCurrentlyOn = !$checkbox.hasClass('off')

    if (isCurrentlyOn) {
        // Turn OFF - change class for smooth dot slide
        $checkbox.addClass('off')

        // Change text without removing dot
        $checkbox.contents().filter(function () {
            return this.nodeType === 3; // Text nodes only
        }).remove()
        $checkbox.prepend(_L('toggle_off'))

        hudConfig.voiceFollowHead = false

        // Remove follow-head class from voice element
        $('.voice').removeClass('follow-head')

        // Notify Lua to stop head tracking
        $.post("https://v-hud/toggleVoiceFollowHead", JSON.stringify({ enabled: false }))
    } else {
        // Turn ON - change class for smooth dot slide
        $checkbox.removeClass('off')

        // Change text without removing dot
        $checkbox.contents().filter(function () {
            return this.nodeType === 3; // Text nodes only
        }).remove()
        $checkbox.prepend(_L('toggle_on'))

        hudConfig.voiceFollowHead = true

        // Add follow-head class to voice element
        $('.voice').addClass('follow-head')

        // Notify Lua to start head tracking
        $.post("https://v-hud/toggleVoiceFollowHead", JSON.stringify({ enabled: true }))
    }

    // Don't auto-save - will be saved when Save button is clicked
})

// Initialize Voice Follow Head from saved config
function initializeVoiceFollowHead() {
    const $checkbox = $('.voice-follow-head-checkbox')
    if (!$checkbox.length) {
        console.warn('Voice Follow Head checkbox not found!')
        return
    }

    if (hudConfig.voiceFollowHead) {
        $checkbox.removeClass('off')
        $checkbox.html(_L('toggle_on') + '<div class="checkbox-dot"></div>')
        $('.voice').addClass('follow-head')

        // Notify Lua to enable head tracking
        $.post("https://v-hud/toggleVoiceFollowHead", JSON.stringify({ enabled: true }))
    } else {
        $checkbox.addClass('off')
        $checkbox.html(_L('toggle_off') + '<div class="checkbox-dot"></div>')
        $('.voice').removeClass('follow-head')
    }
}

// Voice Talk Only Checkbox
$(document).on('click', '.voice-talk-only-checkbox', function (e) {
    e.stopPropagation()

    const $checkbox = $(this)

    // Ensure dot exists
    if ($checkbox.find('.checkbox-dot').length === 0) {
        $checkbox.append('<div class="checkbox-dot"></div>')
    }

    const isCurrentlyOn = !$checkbox.hasClass('off')

    if (isCurrentlyOn) {
        // Turn OFF - change class for smooth dot slide
        $checkbox.addClass('off')

        // Change text without removing dot
        $checkbox.contents().filter(function () {
            return this.nodeType === 3; // Text nodes only
        }).remove()
        $checkbox.prepend(_L('toggle_off'))

        hudConfig.voiceTalkOnly = false

        // Show voice element with fade in
        $('.voice').fadeIn(100)
    } else {
        // Turn ON - change class for smooth dot slide
        $checkbox.removeClass('off')

        // Change text without removing dot
        $checkbox.contents().filter(function () {
            return this.nodeType === 3; // Text nodes only
        }).remove()
        $checkbox.prepend(_L('toggle_on'))

        hudConfig.voiceTalkOnly = true

        // Hide voice element initially (will show when talking) with fade out
        if (!$('.sounds').hasClass('talking')) {
            $('.voice').fadeOut(100)
        }
    }

    // Don't auto-save - will be saved when Save button is clicked
})

// Initialize Voice Talk Only from saved config
function initializeVoiceTalkOnly() {
    const $checkbox = $('.voice-talk-only-checkbox')
    if (!$checkbox.length) {
        console.warn('Voice Talk Only checkbox not found!')
        return
    }

    if (hudConfig.voiceTalkOnly) {
        $checkbox.removeClass('off')
        $checkbox.html(_L('toggle_on') + '<div class="checkbox-dot"></div>')

        // Hide voice if not talking (instant hide on init, no animation)
        if (!$('.sounds').hasClass('talking')) {
            $('.voice').hide()
        }
    } else {
        $checkbox.addClass('off')
        $checkbox.html(_L('toggle_off') + '<div class="checkbox-dot"></div>')
        // Show voice instantly on init (no animation needed at startup)
        $('.voice').show()
    }
}

// Initialize Cinematic Mode from saved config
function initializeCinematicMode() {
    const $checkbox = $('#cinematic-mode-checkbox')
    if (!$checkbox.length) {
        console.warn('Cinematic Mode checkbox not found!')
        return
    }

    if (hudConfig.cinematicMode) {
        $checkbox.removeClass('off')
        $checkbox.html(_L('toggle_on') + '<div class="checkbox-dot"></div>')
        $('body').addClass('cinematic-mode')

        // Hide HUD container when cinematic mode is enabled
        $('.hud-main-container').hide()

        // Move menu to body so it's accessible when HUD is hidden
        if (!$('.hud-menu-container').parent().is('body')) {
            $('.hud-menu-container').appendTo('body')
        }

        // Notify Lua to hide minimap
        $.post("https://v-hud/toggleCinematicMode", JSON.stringify({ enabled: true }))
    } else {
        $checkbox.addClass('off')
        $checkbox.html(_L('toggle_off') + '<div class="checkbox-dot"></div>')
        $('body').removeClass('cinematic-mode')

        // Notify Lua to show minimap
        $.post("https://v-hud/toggleCinematicMode", JSON.stringify({ enabled: false }))
    }
}

// Initialize Hud Visibility from saved config
// NOTE: This only sets checkbox state, does NOT show/hide HUD container
// Container visibility is controlled by "open-ui" action from Lua
function initializeHudVisibility() {
    const $checkbox = $('#hud-visibility-checkbox')
    if (!$checkbox.length) return

    if (hudConfig.hudVisibility === false) {
        $checkbox.addClass('off')
        $checkbox.html(_L('toggle_off') + '<div class="checkbox-dot"></div>')

        // Notify Lua to update state (but don't touch container - it's already hidden)
        $.post("https://v-hud/toggleHudVisibility", JSON.stringify({ visible: false }))
    } else {
        $checkbox.removeClass('off')
        $checkbox.html(_L('toggle_on') + '<div class="checkbox-dot"></div>')

        // DON'T show container here - wait for "open-ui" action from Lua
        // Container starts hidden and only shows after character loads

        // Notify Lua to update state
        $.post("https://v-hud/toggleHudVisibility", JSON.stringify({ visible: true }))
    }
}

// Map details targets to their selectors
const detailsTargetMap = {
    'details-time': '.details-group > .time:first',
    'details-date': '.details-group > .date',
    'details-weather': '.details-group > .weather-group',
    'details-playerid': '.details-group > .time:last',
    'details-money': '.details-group > .money'
}

// Color Pickers - Universal handler
$(document).on('change', '.color-picker-input', function () {
    const $input = $(this)
    const color = $input.val().toUpperCase()
    const target = $input.data('target')

    // Update preview in the same wrapper
    const $wrapper = $input.closest('.color-picker-preview')
    $wrapper.find('.color-code').text(color)
    $wrapper.find('.color-square').css('background-color', color)

    // Handle details group colors (icon-bg + details-text)
    if (target.startsWith('details-')) {
        const selector = detailsTargetMap[target]
        if (selector) {
            $(`${selector} .icon-bg`).css('background-color', color)
            $(`${selector} .details-text`).css('color', color)
            // Also update weather-celsius background for weather
            if (target === 'details-weather') {
                $(`${selector} .weather-celsius`).css('background-color', color)
            }
        }
    } else if (target === 'voice-color') {
        // Apply color to voice icon and all voice bars
        $('.voice-icon-group').css('background-color', color)
        $('.sounds .voice-bar').css('background', color)
    } else if (target === 'horse-hud-group') {
        // Apply color to horse hud text elements and stamina line
        $('.horse-hud-group .current-speed').css('color', color)
        $('.horse-hud-group .default-speed').css('color', color)
        $('.horse-hud-group .speed-text').css('color', color)
        $('.horse-hud-group .horse-stamina .line').css('background-color', color)
    } else {
        // Apply color to the target element circle INSTANTLY
        $(`.${target} .circle`).css('background', `conic-gradient(${color} calc(var(--p) * 3.6deg), transparent 0)`)
    }

    // Store temporarily (don't save to localStorage yet)
    tempColors[target] = color
})

// Click on color preview to open picker
$(document).on('click', '.color-picker-preview', function (e) {
    // Prevent bubbling to avoid infinite loop
    if ($(e.target).hasClass('color-input') || $(e.target).hasClass('color-picker-input')) {
        return // Don't trigger if clicking the input itself
    }
    e.stopPropagation()
    $(this).find('.color-picker-input')[0].click() // Use native click, not jQuery
})

// Initialize all Color Pickers from saved config (uses server theme color)
function initializeAllColors() {
    const defaultColors = {
        'voice-color': defaultThemeColor,
        health: defaultThemeColor,
        stamina: defaultThemeColor,
        water: defaultThemeColor,
        hunger: defaultThemeColor,
        brain: defaultThemeColor,
        bath: defaultThemeColor,
        toilet: defaultThemeColor,
        temparature: defaultThemeColor,
        'horse-health': defaultThemeColor,
        'horse-durabilty': defaultThemeColor,
        'horse-hud-group': defaultThemeColor,
        'details-time': defaultThemeColor,
        'details-date': defaultThemeColor,
        'details-weather': defaultThemeColor,
        'details-playerid': defaultThemeColor,
        'details-money': defaultThemeColor
    }

    // Map details targets to their selectors
    const detailsTargetMap = {
        'details-time': '.details-group > .time:first',
        'details-date': '.details-group > .date',
        'details-weather': '.details-group > .weather-group',
        'details-playerid': '.details-group > .time:last',
        'details-money': '.details-group > .money'
    }

    $('.color-picker-input').each(function () {
        const $input = $(this)
        const target = $input.data('target')
        const savedColor = hudConfig.colors && hudConfig.colors[target]
        const color = savedColor || defaultColors[target] || defaultThemeColor

        $input.prop('value', color)
        const $wrapper = $input.closest('.color-picker-preview')
        $wrapper.find('.color-code').text(color)
        $wrapper.find('.color-square').css('background-color', color)

        // Handle details group colors (icon-bg + details-text)
        if (target.startsWith('details-')) {
            const selector = detailsTargetMap[target]
            if (selector) {
                $(`${selector} .icon-bg`).css('background-color', color)
                $(`${selector} .details-text`).css('color', color)
                // Also update weather-celsius background for weather
                if (target === 'details-weather') {
                    $(`${selector} .weather-celsius`).css('background-color', color)
                }
            }
        } else if (target === 'voice-color') {
            // Apply color to voice icon and all voice bars
            $('.voice-icon-group').css('background-color', color)
            $('.sounds .voice-bar').css('background', color)
        } else if (target === 'horse-hud-group') {
            // Apply color to horse hud text elements and stamina line
            $('.horse-hud-group .current-speed').css('color', color)
            $('.horse-hud-group .default-speed').css('color', color)
            $('.horse-hud-group .speed-text').css('color', color)
            $('.horse-hud-group .horse-stamina .line').css('background-color', color)
        } else {
            // Handle metabolism circle colors
            const $circle = $(`.${target} .circle`)
            if ($circle.length) {
                $circle.css('background', `conic-gradient(${color} calc(var(--p) * 3.6deg), transparent 0)`)
            }
        }
    })
}

// Load saved scale values and apply them
function loadSavedScales() {
    if (hudConfig.scales) {
        for (const selector in hudConfig.scales) {
            const savedScale = hudConfig.scales[selector]
            $(selector).css('transform', `scale(${savedScale})`)

            // Update UI sliders
            const $slider = $(`.size-slider[data-element="${selector}"]`)
            if ($slider.length) {
                const min = 0.5
                const max = 2
                const range = max - min
                const percentage = ((savedScale - min) / range) * 100

                $slider.find('.size-slider-fill').css('width', percentage + '%')
                $slider.find('.size-slider-thumb').css('left', percentage + '%')
                $slider.closest('.size-set').find('.size-value').text(savedScale.toFixed(1))
            }
        }
    }
}

// Update slider UI to match saved config values (called when menu opens)
function updateSlidersFromConfig() {
    $('.size-slider[data-element]').each(function () {
        const $slider = $(this)
        const selector = $slider.data('element')

        // Skip grid size slider (has its own init)
        if ($slider.attr('id') === 'grid-size-slider') return

        const savedScale = hudConfig.scales && hudConfig.scales[selector] ? hudConfig.scales[selector] : 1.0

        const min = 0.5
        const max = 2
        const range = max - min
        const percentage = ((savedScale - min) / range) * 100

        $slider.find('.size-slider-fill').css('width', percentage + '%')
        $slider.find('.size-slider-thumb').css('left', percentage + '%')
        $slider.closest('.size-set').find('.size-value').text(savedScale.toFixed(1))
    })
}

// Initialize all saved settings
setTimeout(function () {
    initializeGridSize()
    initializeCinematicMode()
    initializeHudVisibility()
    initializeVoiceFollowHead()
    initializeVoiceTalkOnly()
    initializeAllColors()
    loadSavedScales()
    // Re-apply server theme after all initializations to ensure theme colors are preserved
    applyServerTheme(serverTheme)
}, 500)

// Apply locales to all UI elements
function applyLocales() {
    if (!locales || Object.keys(locales).length === 0) return

    // Helper: Safely set text if key exists
    const setText = (selector, key) => {
        if (locales[key]) $(selector).text(locales[key])
    }

    // HUD Settings Title & Desc
    setText('.hud-settings-text', 'hud_settings')
    setText('.hud-settings-desc', 'desc_hud_settings')

    // Sidebar Categories
    const categories = {
        'general': 'cat_general',
        'voice': 'cat_voice',
        'weapon': 'cat_weapon',
        'time': 'cat_time',
        'date': 'cat_date',
        'weather': 'cat_weather',
        'playerid': 'cat_playerid',
        'money': 'cat_money',
        'health': 'cat_health',
        'stamina': 'cat_stamina',
        'water': 'cat_water',
        'hungry': 'cat_hunger',
        'stress': 'cat_stress',
        'bath': 'cat_bath',
        'toilet': 'cat_toilet',
        'temperature': 'cat_temp',
        'hhud': 'vis_horse',
        'horse-health': 'vis_horse_health',
        'horse-durabilty': 'vis_horse_stamina'
    }

    for (const [cat, key] of Object.entries(categories)) {
        setText(`.category-item[data-category="${cat}"] .category-name`, key)
    }

    // Dividers
    setText('.divide-name[data-locale-key="div_display"]', 'div_display')
    setText('.divide-name[data-locale-key="div_player_meta"]', 'div_player_meta')
    setText('.divide-name[data-locale-key="div_horse_meta"]', 'div_horse_meta')

    // General Page Groups
    const $generalPage = $('.hud-page[data-page="general"]')
    if ($generalPage.length) {
        if (locales['title_general_layouts']) $generalPage.find('.layout-group-text').eq(0).text(locales['title_general_layouts'])
        if (locales['desc_general_layouts']) $generalPage.find('.layout-group-desc').eq(0).text(locales['desc_general_layouts'])

        if (locales['title_edit_mode']) $generalPage.find('.layout-group-text').eq(1).text(locales['title_edit_mode'])
        if (locales['desc_edit_mode']) $generalPage.find('.layout-group-desc').eq(1).text(locales['desc_edit_mode'])
    }

    // Layout Buttons
    setText('.layout-button[data-layout="standart"]', 'layout_standart')
    setText('.layout-button[data-layout="normal"]', 'layout_normal')
    setText('.layout-button[data-layout="story"]', 'layout_story')

    // Buttons & Inputs
    setText('.edit-btn', 'btn_edit_pos')
    setText('.apply-settings-text', 'btn_apply')
    setText('.apply-settings-desc', 'desc_apply_settings')
    setText('.copy-settings-text', 'btn_copy')
    setText('.reset-btn', 'btn_reset')
    setText('.save-btn', 'btn_save')

    // Global Settings (Grid, Cinematic, HUD Vis)
    setText('.size-header-grp .size-text:first', 'grid_size')
    setText('.size-header-grp .size-desc:first', 'desc_grid_size')

    // Find Cinematic and HUD Vis checkboxes by ID to ensure correct targeting
    const $cinematic = $('#cinematic-mode-checkbox').closest('.hud-visibility-checkbox')
    if ($cinematic.length && locales['cinematic_mode']) $cinematic.find('.hud-visibility-text').text(locales['cinematic_mode'])

    const $hudVis = $('#hud-visibility-checkbox').closest('.hud-visibility-checkbox')
    if ($hudVis.length && locales['hud_visibility']) $hudVis.find('.hud-visibility-text').text(locales['hud_visibility'])

    // Page Specific Settings (Visibility, Size, Desc, Color)
    const pageMapping = [
        { page: 'voice', vis: 'vis_voice', size: 'size_voice', desc: 'desc_size_voice', color: 'color_voice' },
        { page: 'time', vis: 'vis_time', size: 'size_time', desc: 'desc_size_time', color: 'color_time' },
        { page: 'date', vis: 'vis_date', size: 'size_date', desc: 'desc_size_date', color: 'color_date' },
        { page: 'weather', vis: 'vis_weather', size: 'size_weather', desc: 'desc_size_weather', color: 'color_weather' },
        { page: 'playerid', vis: 'vis_playerid', size: 'size_playerid', desc: 'desc_size_playerid', color: 'color_playerid' },
        { page: 'money', vis: 'vis_money', size: 'size_money', desc: 'desc_size_money', color: 'color_money' },
        { page: 'health', vis: 'vis_health', size: 'size_health', desc: 'desc_size_health', color: 'color_health' },
        { page: 'stamina', vis: 'vis_stamina', size: 'size_stamina', desc: 'desc_size_stamina', color: 'color_stamina' },
        { page: 'water', vis: 'vis_water', size: 'size_water', desc: 'desc_size_water', color: 'color_water' },
        { page: 'hungry', vis: 'vis_hunger', size: 'size_hunger', desc: 'desc_size_hunger', color: 'color_hunger' },
        { page: 'stress', vis: 'vis_stress', size: 'size_stress', desc: 'desc_size_stress', color: 'color_stress' },
        { page: 'bath', vis: 'vis_bath', size: 'size_bath', desc: 'desc_size_bath', color: 'color_bath' },
        { page: 'toilet', vis: 'vis_toilet', size: 'size_toilet', desc: 'desc_size_toilet', color: 'color_toilet' },
        { page: 'temperature', vis: 'vis_temp', size: 'size_temp', desc: 'desc_size_temp', color: 'color_temp' },
        { page: 'hhud', vis: 'vis_horse', size: 'size_h_hud', desc: 'desc_size_h_hud', color: 'color_h_hud' },
        { page: 'horse-health', vis: 'vis_horse_health', size: 'size_horse_health', desc: 'desc_size_h_health', color: 'color_horse_health' },
        { page: 'horse-durabilty', vis: 'vis_horse_stamina', size: 'size_horse_stamina', desc: 'desc_size_h_stamina', color: 'color_horse_stamina' }
    ]

    pageMapping.forEach(m => {
        const $p = $(`.hud-page[data-page="${m.page}"]`)
        if ($p.length) {
            if (m.vis && locales[m.vis]) $p.find('.hud-visibility-text').first().text(locales[m.vis])
            if (m.size && locales[m.size]) $p.find('.size-text').first().text(locales[m.size])
            if (m.desc && locales[m.desc]) $p.find('.size-desc').first().text(locales[m.desc])
            if (m.color && locales[m.color]) $p.find('.color-picker-text').text(locales[m.color])
        }
    })

    // Weapon page has dual visibility/size settings (right hand + left hand)
    const $weaponPage = $(`.hud-page[data-page="weapon"]`)
    if ($weaponPage.length) {
        const $visTexts = $weaponPage.find('.hud-visibility-text')
        const $sizeTexts = $weaponPage.find('.size-text')
        const $descTexts = $weaponPage.find('.size-desc')

        if ($visTexts.length >= 2) {
            if (locales['vis_weapon_right']) $visTexts.eq(0).text(locales['vis_weapon_right'])
            if (locales['vis_weapon_left']) $visTexts.eq(1).text(locales['vis_weapon_left'])
        }
        if ($sizeTexts.length >= 2) {
            if (locales['size_weapon_right']) $sizeTexts.eq(0).text(locales['size_weapon_right'])
            if (locales['size_weapon_left']) $sizeTexts.eq(1).text(locales['size_weapon_left'])
        }
        if ($descTexts.length >= 2) {
            if (locales['desc_size_weapon_right']) $descTexts.eq(0).text(locales['desc_size_weapon_right'])
            if (locales['desc_size_weapon_left']) $descTexts.eq(1).text(locales['desc_size_weapon_left'])
        }
    }

    // Voice Follow Head checkbox (apply after pageMapping to avoid override)
    const $voiceFollowHead = $('.voice-follow-head-checkbox').closest('.hud-visibility-checkbox')
    if ($voiceFollowHead.length && locales['voice_follow_head']) $voiceFollowHead.find('.hud-visibility-text').text(locales['voice_follow_head'])

    // Voice Talk Only checkbox (apply after pageMapping to avoid override)
    const $voiceTalkOnly = $('.voice-talk-only-checkbox').closest('.hud-visibility-checkbox')
    if ($voiceTalkOnly.length && locales['voice_talk_only']) $voiceTalkOnly.find('.hud-visibility-text').text(locales['voice_talk_only'])

    // Toggle Button States (ON/OFF)
    $('.hud-settings-checkbox').each(function () {
        const $checkbox = $(this)
        const isOff = $checkbox.hasClass('off')
        const text = isOff ? (locales.toggle_off || 'OFF') : (locales.toggle_on || 'ON')

        // Update text node only, preserve checkbox-dot
        $checkbox.contents().filter(function () { return this.nodeType === 3 }).remove()
        $checkbox.prepend(text)
    })

    // HUD Main Details Labels (Time:, Date: etc.)
    setText('.details-group > .time:first .details-title', 'label_time')
    setText('.details-group > .date .details-title', 'label_date')
    setText('.details-group > .weather-group .details-title', 'label_weather')
    setText('.details-group > .time:last .details-title', 'label_playerid')
    setText('.details-group > .money .details-title', 'label_money')

    // Celsius unit
    setText('.weather-celsius .celsius-title', 'unit_celsius')
    setText('.temparature-group .celius-title', 'unit_celsius')
}
