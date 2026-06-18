--------------------------
-- VERSION 1.7 - 24.02.26
--------------------------

if NuiFocusKeep == nil then
    local _sirevlc_focus_on = false
    local _sirevlc_has_keep = (SetNuiFocusKeepInput ~= nil)

    function NuiFocusKeep(want)
        if want then
            if _sirevlc_has_keep then SetNuiFocusKeepInput(true) end
            SetNuiFocus(true, true)
            if _sirevlc_has_keep then SetNuiFocusKeepInput(true) end
            _sirevlc_focus_on = true
        else
            if _sirevlc_has_keep then SetNuiFocusKeepInput(false) end
            SetNuiFocus(false, false)
            _sirevlc_focus_on = false
        end
    end

    -- Keep cursor alive while focused (RedM sometimes needs it each frame)
    CreateThread(function()
        while true do
            if _sirevlc_focus_on then
                -- (disabled) SetMouseCursorActiveThisFrame() to avoid double cursor
                -- (disabled) SetMouseCursorSprite(0) to avoid double cursor
            end
            Wait(0)
        end
    end)

		-- Diagnostics to console (one-shot on resource start)
    CreateThread(function()
        Wait(250)
         -- print("^3[menu_base] SetNuiFocusKeepInput available: ^7"..tostring(SetNuiFocusKeepInput ~= nil))
         -- print("^3[menu_base] Using NuiFocusKeep helper for focus handling.^7")
    end)
end

MenuData = {}
 
local _sirevlc_wheelBlockUntil = 0
 
CreateThread(function()
    while true do
        if MenuData and MenuData._focusOpen == true then
         --  if GetGameTimer() < _sirevlc_wheelBlockUntil then
            -- Block mouse wheel from also affecting gameplay while the menu is open.
            -- (Useful when you use scroll for menu navigation but your camera script also uses wheel.)
 				DisableControlAction(0,0x430593AA, true) 
				DisableControlAction(0,0x7ABC6A66, true) 
				DisableControlAction(0,0x8BDE7443, true) 
				DisableControlAction(0,0x9DA42644, true) 
				DisableControlAction(0,0xD0842EDF, true) 
				DisableControlAction(0,0xFD0F0C2C, true) 
				DisableControlAction(0,0x3076E97C, true) 
				DisableControlAction(0,0x406ADFAE, true) 
				DisableControlAction(0,0x62800C92, true) 
				DisableControlAction(0,0x81457A1A, true) 
				DisableControlAction(0,0x841240A9, true) 
				DisableControlAction(0,0xA5BDCD3C, true) 
				DisableControlAction(0,0xEB4130DF, true) 
				DisableControlAction(0,0xF78D7337, true) 
				DisableControlAction(0,0xCC1075A7, true) 
				-- BLOCK ESCAPE 
				DisableControlAction(0,0x156F7119, true) 
				DisableControlAction(0,0x308588E6, true) 
				DisableControlAction(0,0x4A903C11, true) 
				DisableControlAction(0,0x5B48F938, true) 
				DisableControlAction(0,0x8E90C7BB, true) 	
				DisableControlAction(0,0xE9094BA0, true) 	
				DisableControlAction(0,0x3E89055A, true) 	
        --    end
        end
        Wait(0)
    end
end)

-- === end per-frame disable ===
MenuData.Opened = {}
MenuData.RegisteredTypes = {}
MenuData.KeyboardThread = nil
MenuData.KeyboardThreadStop = false
MenuData._confirmBack = {}
-- Guard against double-cancel bursts (ex: BACKSPACE then a ghost ESCAPE a few ms later)
MenuData._lastCancel = {}

-- Returns whether the top-most opened menu wants NUI focus (mouse cursor)
local function _SireMenu_GetTopWantFocus()
    for i = #MenuData.Opened, 1, -1 do
        local m = MenuData.Opened[i]
        if m and m.data then
            if m.data.nuifocus ~= nil then
                return (m.data.nuifocus == true)
            end
            return false
        end
    end
    return false
end


-- Default preset
MenuData.RegisteredTypes['default'] = {
    open  = function(namespace, name, data)
            local wantFocus = (data and data.nuifocus ~= nil) and data.nuifocus or false
    NuiFocusKeep(wantFocus)
-- Focus handling        if data and data.nuifocus ~= nil then wantFocus = data.nuifocus end
if SetNuiFocusKeepInput ~= nil then
            if wantFocus then
-- allow keyboard passthrough while NUI is focused
            else
end
        end
        MenuData._focusOpen = wantFocus and true or false

         -- print('[MenuData] Opening menu', namespace, name, 'type='..tostring(MenuType))
        SendNUIMessage({
            sire_menu_action = 'openMenu',
            sire_menu_nuifocus = (data and data.nuifocus),
            sire_menu_mouseHoverArrows = (data and data.mouseHoverArrows),
            sire_menu_namespace = namespace,
            sire_menu_name = name,
            sire_menu_resourcename = GetCurrentResourceName(),
            sire_menu_data = data
        })
        -- capture confirmBack flags for this menu (used by keyboard thread)
        MenuData._confirmBack[namespace] = MenuData._confirmBack[namespace] or {}
        MenuData._confirmBack[namespace][name] = {
            text = (data and data.confirmBackText) or nil,
            yes  = (data and data.confirmBackText_Yes) or nil,
            no   = (data and data.confirmBackText_No) or nil
        }


        -- Start keyboard thread for menu navigation ONLY when we don't want NUI focus
        if not wantFocus then
            if MenuData.KeyboardThread ~= nil then
                MenuData.KeyboardThreadStop = true
                MenuData.KeyboardThread = nil
                Citizen.Wait(0)
            end
            MenuData.KeyboardThreadStop = false
            MenuData.KeyboardThread = Citizen.CreateThread(function()
                 -- print("[MenuData] Keyboard thread started for", namespace, name)
                while not MenuData.KeyboardThreadStop do
                    Citizen.Wait(0)
                    -- Arrow keys + ENTER/BACKSPACE (frontend controls)
                    if IsControlJustPressed(0, 172) then -- INPUT_FRONTEND_UP
                        SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'UP' })
                    elseif IsControlJustPressed(0, 173) then -- INPUT_FRONTEND_DOWN
                        SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'DOWN' })
                    elseif IsControlJustPressed(0, 174) then -- INPUT_FRONTEND_LEFT
                        SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'LEFT' })
                    elseif IsControlJustPressed(0, 175) then -- INPUT_FRONTEND_RIGHT
                        SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'RIGHT' })
                    elseif IsControlJustPressed(0, 191) then -- INPUT_FRONTEND_ACCEPT (ENTER)
                        SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'ENTER' })
                    elseif IsControlJustPressed(0, 194) then -- INPUT_FRONTEND_CANCEL (BACK)
                        local ns, nm = namespace, name
                        local flags = MenuData._confirmBack[ns] and MenuData._confirmBack[ns][nm]
                        if flags and flags.text and tostring(flags.text) ~= "" then
                            SendNUIMessage({ sire_menu_action = 'showConfirmBack', text = flags.text, yes = flags.yes, no = flags.no })
                        else
                            SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'BACKSPACE' })
                        end
                    end
                end
                 -- print("[MenuData] Keyboard thread stopped for", namespace, name)
            end)
        end
    end,

    close = function(namespace, name)
            NuiFocusKeep(false)
-- Stop keyboard thread if running
        if MenuData.KeyboardThread ~= nil then
            MenuData.KeyboardThreadStop = true
            MenuData.KeyboardThread = nil
    end

        -- Disable NUI focus when closing
        SetNuiFocus(false, false)
        if SetNuiFocusKeepInput ~= nil then SetNuiFocusKeepInput(false) end
        MenuData._focusOpen = false

        SendNUIMessage({
            sire_menu_action = 'closeMenu',
            sire_menu_namespace = namespace,
            sire_menu_name = name
        })
    end
}

-- Preset: menu_base (same behavior as default)
MenuData.RegisteredTypes['menu_base'] = {
    open  = function(namespace, name, data)
        local wantFocus = (data and data.nuifocus ~= nil) and data.nuifocus or false
        NuiFocusKeep(wantFocus)

        -- Focus flag (celui que ton thread check)
        MenuData._focusOpen = wantFocus and true or false

        SendNUIMessage({
            sire_menu_action = 'openMenu',
            -- Pass through flags
            sire_menu_nuifocus = (data and data.nuifocus),
            sire_menu_mouseHoverArrows = (data and data.mouseHoverArrows),
            sire_menu_namespace = namespace,
            sire_menu_name = name,
            sire_menu_resourcename = GetCurrentResourceName(),
            sire_menu_data = data
        })

        -- capture confirmBack flags for this menu (used by keyboard thread)
        MenuData._confirmBack[namespace] = MenuData._confirmBack[namespace] or {}
        MenuData._confirmBack[namespace][name] = {
            text = (data and data.confirmBackText) or nil,
            yes  = (data and data.confirmBackText_Yes) or nil,
            no   = (data and data.confirmBackText_No) or nil
        }

        -- Start keyboard thread for menu navigation (works with nuifocus true/false)
        do
            if MenuData.KeyboardThread ~= nil then
                MenuData.KeyboardThreadStop = true
                MenuData.KeyboardThread = nil
                Citizen.Wait(0)
            end

            MenuData.KeyboardThreadStop = false
            MenuData.KeyboardThread = Citizen.CreateThread(function()
                while not MenuData.KeyboardThreadStop do
                    Citizen.Wait(0)

                    -- Arrow keys + ENTER/BACKSPACE (frontend controls)
                    if IsControlJustPressed(0, 172) then -- INPUT_FRONTEND_UP
                        SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'UP' })
                    elseif IsControlJustPressed(0, 173) then -- INPUT_FRONTEND_DOWN
                        SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'DOWN' })
                    elseif IsControlJustPressed(0, 174) then -- INPUT_FRONTEND_LEFT
                        SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'LEFT' })
                    elseif IsControlJustPressed(0, 175) then -- INPUT_FRONTEND_RIGHT
                        SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'RIGHT' })
                    elseif IsControlJustPressed(0, 191) then -- INPUT_FRONTEND_ACCEPT (ENTER)
                        SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'ENTER' })
                    elseif IsControlJustPressed(0, 194) then -- INPUT_FRONTEND_CANCEL (BACK)
                        local ns, nm = namespace, name
                        local flags = MenuData._confirmBack[ns] and MenuData._confirmBack[ns][nm]
                        if flags and flags.text and tostring(flags.text) ~= "" then
                            SendNUIMessage({ sire_menu_action = 'showConfirmBack', text = flags.text, yes = flags.yes, no = flags.no })
                        else
                            SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'BACKSPACE' })
                        end
                    end
                end
            end)
        end
    end,

    close = function(namespace, name)
        NuiFocusKeep(false)

        -- Stop keyboard thread if running
        if MenuData.KeyboardThread ~= nil then
            MenuData.KeyboardThreadStop = true
            MenuData.KeyboardThread = nil
        end

        SetNuiFocus(false, false)
        if SetNuiFocusKeepInput ~= nil then SetNuiFocusKeepInput(false) end

        -- IMPORTANT: coupe le flag qui fait tourner ton thread DisableControlAction
        MenuData._focusOpen = false

        -- (optionnel) cleanup confirmBack pour ce menu
        if MenuData._confirmBack[namespace] then
            MenuData._confirmBack[namespace][name] = nil
        end

        SendNUIMessage({
            sire_menu_action = 'closeMenu',
            sire_menu_namespace = namespace,
            sire_menu_name = name
        })
    end
}


-- Preset: menu_progress (same behavior as menu_base, extra NUI rendering via element.progress/sub_label)
MenuData.RegisteredTypes['menu_progress'] = MenuData.RegisteredTypes['menu_base']

function MenuData.Open(menuType, namespace, name, data, submit, cancel, change, close)
    local menu = {}

    menu.type = menuType
    menu.namespace = namespace
    menu.name = name
    menu.data = data
    menu.submit = submit
    menu.cancel = cancel
    menu.change = change
    menu.close_cb = close

    menu.close = function()
        MenuData.RegisteredTypes[menu.type].close(namespace, name, false)

        for i = 1, #MenuData.Opened, 1 do
            if MenuData.Opened[i] then
                if MenuData.Opened[i].type == menu.type and MenuData.Opened[i].namespace == namespace and MenuData.Opened[i].name == name then
                    MenuData.Opened[i] = nil
                end
            end
        end

        if menu.close_cb then
            menu.close_cb(name)
        end
    end

    menu.update = function(query, newData)
        for i = 1, #menu.data.elements, 1 do
            local match = true
            for k, v in pairs(query) do
                if menu.data.elements[i][k] ~= v then
                    match = false
                end
            end
            if match then
                for k, v in pairs(newData) do
                    menu.data.elements[i][k] = v
                end
            end
        end
    end

    menu.addNewElement = function(element)
        menu.data.elements[#menu.data.elements + 1] = element
    end

    menu.removeElementByValue = function(value, stop)
        for i = 1, #menu.data.elements, 1 do
            if menu.data.elements[i] then
                if menu.data.elements[i].value == value then
                    table.remove(menu.data.elements, i)
                    if stop then break end
                end
            end
        end
    end

    menu.removeElementByIndex = function(index, stop)
        for i = 1, #menu.data.elements, 1 do
            if menu.data.elements[i] then
                if i == index then
                    table.remove(menu.data.elements, i)
                    if stop then break end
                end
            end
        end
    end

    menu.refresh = function()
        MenuData.RegisteredTypes[menu.type].open(namespace, name, menu.data)
    end

    menu.setElement = function(i, key, val)
        menu.data.elements[i][key] = val
    end

    menu.setElements = function(newElements)
        menu.data.elements = newElements
    end

    menu.setTitle = function(val)
        menu.data.title = val
    end

    menu.removeElement = function(query)
        for i = 1, #menu.data.elements, 1 do
            for k, v in pairs(query) do
                if menu.data.elements[i] then
                    if menu.data.elements[i][k] == v then
                        menu.data.elements[i] = nil
                        break
                    end
                end
            end
        end
    end

    MenuData.Opened[#MenuData.Opened + 1] = menu

    -- IMPORTANT: remember the active menu "type" so NUI callbacks look up the right menu.
    MenuType = menuType

    MenuData.RegisteredTypes[menuType].open(namespace, name, data)
    PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
    return menu
end

function MenuData.Close(menuType, namespace, name)
    for i = 1, #MenuData.Opened, 1 do
        local m = MenuData.Opened[i]
        if m and m.type == menuType and m.namespace == namespace and m.name == name then
            m.close()
            MenuData.Opened[i] = nil
        end
    end
end

function MenuData.CloseAll()
    for i = 1, #MenuData.Opened, 1 do
        if MenuData.Opened[i] then
            MenuData.Opened[i].close()
            MenuData.Opened[i] = nil
        end
    end

    -- failsafe 
    MenuData._focusOpen = false
    NuiFocusKeep(false)
    SetNuiFocus(false, false)
    if SetNuiFocusKeepInput ~= nil then SetNuiFocusKeepInput(false) end
end

function MenuData.GetMenus()
    for i = 1, #MenuData.Opened, 1 do
        if MenuData.Opened[i] then
            return true
        end
    end
end

function MenuData.GetOpened(menuType, namespace, name)
    -- First pass: strict match on type + namespace + name
    for i = 1, #MenuData.Opened, 1 do
        local m = MenuData.Opened[i]
        if m and m.type == menuType and m.namespace == namespace and m.name == name then
            return m
        end
    end
    -- Fallback: ignore type, match only namespace + name
    for i = 1, #MenuData.Opened, 1 do
        local m = MenuData.Opened[i]
        if m and m.namespace == namespace and m.name == name then
            return m
        end
    end
    return nil
end

function MenuData.GetOpenedMenus()
    return MenuData.Opened
end

function MenuData.IsOpen(type, namespace, name)
    return MenuData.GetOpened(type, namespace, name) ~= nil
end

function MenuData.ReOpen(oldMenu)
    MenuData.Open(oldMenu.type, oldMenu.namespace, oldMenu.name, oldMenu.data, oldMenu.submit, oldMenu.cancel, oldMenu.change, oldMenu.close_cb)
end

local Timer, MenuType = 0, 'default'

RegisterNUICallback('menu_submit', function(data, cb)
     -- print('[NUI] menu_submit received', 'ns='..tostring(data._namespace), 'name='..tostring(data._name))
    PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
    local menu = MenuData.GetOpened(MenuType, data._namespace, data._name)
    if not menu then
         -- print('[NUI] menu_submit ERROR: menu not found for', 'type='..tostring(MenuType), 'ns='..tostring(data._namespace), 'name='..tostring(data._name))
        if cb then cb('ok') end
        return
    end
    if menu and menu.submit ~= nil then
        menu.submit(data, menu)
    end
    if cb then cb('ok') end
end)

RegisterNUICallback('playsound', function(data, cb)
    local which = nil
    local dt = type(data)

    if dt == 'table' then
        which = data.which or data.id or data.event or data.sound or data[1]
    elseif dt == 'string' then
        which = data
    end

    -- Debug log to verify which sound is requested
--  -- print('[NUI] playsound, which =', which or 'nil')

    if which == 'slider_step' then
        PlaySoundFrontendWithSoundId(1, "NAV_RIGHT", "HUD_PLAYER_MENU", true)
    elseif which == 'confirm_open' then
        -- Requested confirm sound when confirmNext window opens
        PlaySoundFrontendWithSoundId(1, "MENU_ENTER", "HUD_PLAYER_MENU", true)
    elseif which == 'confirm_close' then
        PlaySoundFrontendWithSoundId(1, "MENU_CLOSE", "HUD_PLAYER_MENU", true)
    else
        PlaySoundFrontend("NAV_LEFT", "PAUSE_MENU_SOUNDSET", true, 0)
    end

    if cb then cb('ok') end
end)

RegisterNUICallback('menu_cancel', function(data, cb)
   --   -- print('[NUI] menu_cancel received', 'ns='..tostring(data._namespace), 'name='..tostring(data._name))
    PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
    local menu = MenuData.GetOpened(MenuType, data._namespace, data._name)
    if not menu then
     --     -- print('[NUI] menu_cancel ERROR: menu not found for', 'type='..tostring(MenuType), 'ns='..tostring(data._namespace), 'name='..tostring(data._name))
        if cb then cb('ok') end
        return
    end
    if menu and menu.cancel ~= nil then
        -- Debounce: if we just processed a BACKSPACE cancel for this same menu,
        -- ignore a trailing ESCAPE cancel arriving a moment later.
        local ns = data and data._namespace
        local nm = data and data._name
        local trig = (data and data.trigger) or 'UNKNOWN'
        local now = GetGameTimer()

        if ns and nm then
            MenuData._lastCancel[ns] = MenuData._lastCancel[ns] or {}
            local last = MenuData._lastCancel[ns][nm]
            if trig == 'ESCAPE' and last and last.trig == 'BACKSPACE' and last.t and (now - last.t) < 350 then
                if cb then cb('ok') end
                return
            end
            MenuData._lastCancel[ns][nm] = { t = now, trig = trig }
        end

        -- 3rd param = wasEsc (true if cancel came from ESC)
        menu.cancel(data, menu, (data and data.trigger == 'ESCAPE') and true or false)
    end
    if cb then cb('ok') end
end)

RegisterNUICallback('menu_change', function(data, cb)
     --  -- print('[NUI] menu_change received', 'ns='..tostring(data._namespace), 'name='..tostring(data._name))
    local menu = MenuData.GetOpened(MenuType, data._namespace, data._name)
    if not menu then
      --    -- print('[NUI] menu_change ERROR: menu not found for', 'type='..tostring(MenuType), 'ns='..tostring(data._namespace), 'name='..tostring(data._name))
        if cb then cb('ok') end
        return
    end

    for i = 1, #data.elements, 1 do
        if menu.data.elements[i] ~= nil then
            menu.setElement(i, 'value', data.elements[i].value)
            menu.setElement(i, 'selected', data.elements[i].selected == true)
        end
    end

    if menu.change ~= nil then
        menu.change(data, menu)
    end
    if cb then cb('ok') end
end)



RegisterNUICallback('menu_wheel', function(data, cb)
    -- Temporarily block gameplay wheel actions only when the UI actually used the wheel
    _sirevlc_wheelBlockUntil = GetGameTimer() + (data and data.ms and tonumber(data.ms) or 200)
    if cb then cb('ok') end
end)
-- Legacy keyboard fallback (kept intact)
Citizen.CreateThread(function()
    local PauseMenuState = false
    local MenusToReOpen  = {}
    while true do
        Citizen.Wait(0)
        if #MenuData.Opened > 0 then
            -- Keyboard controls remain as fallback
            if (IsControlJustReleased(0, 0x43DBF61F) or IsDisabledControlJustReleased(0, 0x43DBF61F)) then -- ENTER
                SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'ENTER' })
            end
            if (IsControlJustReleased(0, 0x308588E6) or IsDisabledControlJustReleased(0, 0x308588E6)) then -- BACKSPACE
                local ns, nm = namespace, name
                local flags = MenuData._confirmBack[ns] and MenuData._confirmBack[ns][nm]
                if flags and flags.text and tostring(flags.text) ~= "" then
                    SendNUIMessage({ sire_menu_action = 'showConfirmBack', text = flags.text, yes = flags.yes, no = flags.no })
                else
                    SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'BACKSPACE' })
                end
            end

            -- ESCAPE (send a different trigger so scripts can know why cancel fired)
            if (IsControlJustReleased(0, 0x156F7119) or IsDisabledControlJustReleased(0, 0x156F7119)) then -- ESC
                SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'ESCAPE' })
            end
            if (IsControlJustReleased(0, 0x911CB09E) or IsDisabledControlJustReleased(0, 0x911CB09E)) then -- TOP
                SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'TOP' })
            end
            if (IsControlJustReleased(0, 0x4403F97F) or IsDisabledControlJustReleased(0, 0x4403F97F)) then -- DOWN
                SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'DOWN' })
            end
            if (IsControlJustReleased(0, 0xAD7FCC5B) or IsDisabledControlJustReleased(0, 0xAD7FCC5B)) then -- LEFT
                SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'LEFT' })
            end
            if (IsControlJustReleased(0, 0x65F9EC5B) or IsDisabledControlJustReleased(0, 0x65F9EC5B)) then -- RIGHT
                SendNUIMessage({ sire_menu_action = 'controlPressed', sire_menu_control = 'RIGHT' })
            end

            if IsPauseMenuActive() then
                if not PauseMenuState then
                    PauseMenuState = true
                    for k, v in pairs(MenuData.GetOpenedMenus()) do
                        table.insert(MenusToReOpen, v)
                    end
                    MenuData.CloseAll()
                end
            end
        else
            if PauseMenuState and not IsPauseMenuActive() then
                PauseMenuState = false
                Citizen.Wait(1000)
                for k, v in pairs(MenusToReOpen) do
                    MenuData.ReOpen(v)
                end
                MenusToReOpen = {}
            end
        end
    end
end)

RegisterNUICallback('closeui', function(_, cb)
    -- Only drop focus if no menus are open anymore.
    -- When a cancel/back opens another menu, MenuData.GetMenus() will be true,
    -- so we keep (or restore) NUI focus for proper mouse usage.
    local hasMenus = false
    if MenuData and MenuData.GetMenus then
        hasMenus = MenuData.GetMenus()
    end

    if hasMenus then
        -- There is still at least one menu open; restore focus according to the top menu's nuifocus flag.
        local wantFocus = _SireMenu_GetTopWantFocus()
        NuiFocusKeep(wantFocus)
        MenuData._focusOpen = wantFocus and true or false
    else
        -- No menu left, fully release focus back to the game
        SetNuiFocus(false, false)
        if SetNuiFocusKeepInput ~= nil then SetNuiFocusKeepInput(false) end
        TriggerEvent("sire_menu:closemenu")
    end

    if cb then cb('ok') end
end)

AddEventHandler('sire_menu:getData', function(cb)
    cb(MenuData)
end)

-- Allow scripts to mark the current menu as ready/not ready for navigation gating
function MenuData.SetScrollReady(namespace, name, ready)
    SendNUIMessage({
        sire_menu_action = 'setScrollReady',
        sire_menu_namespace = namespace,
        sire_menu_name = name,
        ready = ready and true or false
    })
end
 
local __sirevlcLastGradients = {}
RegisterNetEvent('sire_menu:menu_set_gradients', function(payload)
    if type(payload) ~= 'table' then return end

    local ns   = payload._namespace or payload.namespace
    local name = payload._name      or payload.name
    if not ns or not name then return end

    local items = payload.items
    if type(items) ~= 'table' then return end

    __sirevlcLastGradients[ns] = __sirevlcLastGradients[ns] or {}
    local cache = __sirevlcLastGradients[ns]
    local baseKey = tostring(name) .. "::"

    local changed = false

    for _, it in ipairs(items) do
        if it and it.index and it.gradient then
            local key = baseKey .. tostring(it.index)
            if cache[key] ~= it.gradient then
                cache[key] = it.gradient
                changed = true
            end
        end
    end

    if not changed then
        return
    end

    payload.action = "menu_set_gradients"
    SendNUIMessage(payload)
end)
 
RegisterNetEvent('sire_menu:pause_desc', function(ms)
    -- Allow calling TriggerEvent('sire_menu:pause_desc', 6000)
    local duration = tonumber(ms)
    if duration < 0 then 
	duration = 0 
	end

    SendNUIMessage({
        sire_menu_action = 'pause_desc',
        sire_menu_ms = duration
    })
end)

-- Show desc tips now, then automatically hide them after X ms
RegisterNetEvent('sire_menu:hide_desc', function(ms)
    -- Allow calling TriggerEvent('sire_menu:hide_desc', 10000)
    local duration = tonumber(ms) or 0
    if duration < 0 then duration = 0 end

    SendNUIMessage({
        sire_menu_action = 'hide_desc',
        sire_menu_ms = duration
    })
end)

-- Optional export helper (client-side)
exports('HideDescTips', function(ms)
    TriggerEvent('sire_menu:hide_desc', ms)
end)
 
local _tameSliderVisible = false
local _tameSliderValue = 0

local function _clamp(v,a,b)
    if v < a then return a end
    if v > b then return b end
    return v
end

local function _tameSend(action, payload)
    payload = payload or {}
    payload.sire_menu_action = action
    SendNUIMessage(payload)
end

exports('TameSliderShow', function(minTol, maxTol, value)
    _tameSliderVisible = true
    if value ~= nil then _tameSliderValue = tonumber(value) or _tameSliderValue end
    _tameSend('tameSliderShow', {
        minTol = tonumber(minTol) or -20,
        maxTol = tonumber(maxTol) or 20,
        value  = _tameSliderValue
    })
end)

exports('TameSliderHide', function()
    _tameSliderVisible = false
    _tameSend('tameSliderHide', {})
end)

exports('TameSliderSet', function(value)
    _tameSliderValue = _clamp(tonumber(value) or 0, -100, 100)
    if _tameSliderVisible then
        _tameSend('tameSliderUpdate', { value = _tameSliderValue })
    end
end)

exports('TameSliderAdd', function(delta)
    delta = tonumber(delta) or 0
    exports[GetCurrentResourceName()]:TameSliderSet(_tameSliderValue + delta)
end)

 
local _ropeSliderVisible = false

local function _ropeSend(action, payload)
    payload = payload or {}
    payload.sire_menu_action = action
    SendNUIMessage(payload)
end

exports('RopeSliderShow', function(ballPct, horsePct, tolStartPct, tolWidthPct, out, wrongDir)
    _ropeSliderVisible = true
    _ropeSend('ropeSliderShow', {
        ballPct = tonumber(ballPct) or 0,
        horsePct = tonumber(horsePct) or 0,
        tolStartPct = tonumber(tolStartPct) or 0,
        tolWidthPct = tonumber(tolWidthPct) or 14,
        out = out and true or false,
        wrongDir = wrongDir and true or false
    })
end)

exports('RopeSliderHide', function()
    _ropeSliderVisible = false
    _ropeSend('ropeSliderHide', {})
end)

exports('RopeSliderUpdate', function(ballPct, horsePct, tolStartPct, tolWidthPct, out, wrongDir)
    if not _ropeSliderVisible then return end
    _ropeSend('ropeSliderUpdate', {
        ballPct = tonumber(ballPct) or 0,
        horsePct = tonumber(horsePct) or 0,
        tolStartPct = tonumber(tolStartPct) or 0,
        tolWidthPct = tonumber(tolWidthPct) or 14,
        out = out and true or false,
        wrongDir = wrongDir and true or false
    })
end)
 
exports('RopeSliderFlip', function(flip)
    if not _ropeSliderVisible then return end
    _ropeSend('ropeSliderFlip', { flip = flip and true or false })
end)
 
AddEventHandler('sire_menu', function(action, elements)
    if action == 'HUD_INFO' then
        if type(elements) ~= 'table' then elements = {} end
        SendNUIMessage({ sire_menu_action = 'hudInfoShow', payload = elements })
        return
    end

    if action == 'close' then
        SendNUIMessage({ sire_menu_action = 'hudInfoHide' })
        return
    end
end)

