Config = Config or {}


-- Weapons list for context menu "Give Weapon..." submenu
-- Each entry: { id = 'knife', label = 'Knife', weapon = 'WEAPON_MELEE_KNIFE' }
Config.Weapons = {
     --Melee (examples)
    { id = 'knife', label = 'Knife', weapon = 'WEAPON_MELEE_KNIFE' },
    
    -- Pistols
    { id = 'pistol_semiauto', label = 'Pistol Semi-Auto', weapon = 'WEAPON_PISTOL_SEMIAUTO' },
    { id = 'pistol_mauser', label = 'Pistol Mauser', weapon = 'WEAPON_PISTOL_MAUSER' },
    { id = 'pistol_volcanic', label = 'Pistol Volcanic', weapon = 'WEAPON_PISTOL_VOLCANIC' },
    { id = 'pistol_m1899', label = 'Pistol M1899', weapon = 'WEAPON_PISTOL_M1899' },
    
    -- Revolvers
    { id = 'revolver_cattleman', label = 'Revolver Cattleman', weapon = 'WEAPON_REVOLVER_CATTLEMAN' },
    { id = 'revolver_cattleman_mexican', label = 'Revolver Cattleman Mexican', weapon = 'WEAPON_REVOLVER_CATTLEMAN_MEXICAN' },
    { id = 'revolver_schofield', label = 'Revolver Schofield', weapon = 'WEAPON_REVOLVER_SCHOFIELD' },
    { id = 'revolver_doubleaction', label = 'Revolver Double Action', weapon = 'WEAPON_REVOLVER_DOUBLEACTION' },
    -- { id = 'revolver_navy', label = 'Revolver Navy', weapon = 'WEAPON_REVOLVER_NAVY' }, --not working with peds currecntly
    -- { id = 'revolver_navy_crossover', label = 'Revolver Navy Crossover', weapon = 'WEAPON_REVOLVER_NAVY_CROSSOVER' }, --not working with peds currecntly
    -- { id = 'revolver_lemat', label = 'Revolver Lemat', weapon = 'WEAPON_REVOLVER_LEMAT' }, --not working with peds currecntly
    
    -- Rifles
    { id = 'rifle_varmint', label = 'Varmint Rifle', weapon = 'WEAPON_RIFLE_VARMINT' },
    { id = 'rifle_boltaction', label = 'Bolt-Action Rifle', weapon = 'WEAPON_RIFLE_BOLTACTION' },
    { id = 'rifle_springfield', label = 'Springfield Rifle', weapon = 'WEAPON_RIFLE_SPRINGFIELD' },
    
    -- Shotguns
    { id = 'shotgun_doublebarrel', label = 'Double Barrel Shotgun', weapon = 'WEAPON_SHOTGUN_DOUBLEBARREL' },
    { id = 'shotgun_doublebarrel_exotic', label = 'Double Barrel Exotic Shotgun', weapon = 'WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC' },
    { id = 'shotgun_sawedoff', label = 'Sawed-Off Shotgun', weapon = 'WEAPON_SHOTGUN_SAWEDOFF' },
    { id = 'shotgun_repeating', label = 'Repeating Shotgun', weapon = 'WEAPON_SHOTGUN_REPEATING' },
    { id = 'shotgun_pump', label = 'Pump Shotgun', weapon = 'WEAPON_SHOTGUN_PUMP' },
    { id = 'shotgun_semiauto', label = 'Semi-Auto Shotgun', weapon = 'WEAPON_SHOTGUN_SEMIAUTO' },
    
    -- Bows
    { id = 'bow', label = 'Bow', weapon = 'WEAPON_BOW' },

}

-- Animations list for context menu "Animations..." submenu
-- Each entry:
-- { id = 'cheer', label = 'Cheer', dict = 'anim_dictionary', name = 'animation_name', blendInSpeed = 2.0, blendOutSpeed = 2.0, duration = -1, flag = 1, playbackRate = 0.0 }
-- Flags refer to eScriptedAnimFlags, e.g. 1 = AF_LOOPING, 2 = AF_HOLD_LAST_FRAME, 4 = AF_REPOSITION_WHEN_FINISHED, 8 = AF_NOT_INTERRUPTABLE, 16 = AF_UPPERBODY, ...
Config.Animations = {
    { id = 'gentletip', label = 'Gentle Tip', dict = 'mech_loco_m@character@dutch@fancy@unarmed@idle@_variations', name = 'idle_b', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = 2500, flag = 31, playbackRate = 0.0 },
    { id = 'neutralt', label = 'Neutral Wave', dict = 'mech_loco_m@character@nicholas_timmins@normal@unarmed@idle@variations@big_wave', name = 'idle', blendInSpeed = -1.0, blendOutSpeed = 1.0, duration = 3000, flag = 31, playbackRate = 0.0 },
    { id = 'diskrettip', label = 'Discreet Tip (Hat)', dict = 'mech_loco_m@character@arthur@fidgets@hat@normal@unarmed@normal@left_hand', name = 'hat_lhand_b', blendInSpeed = -1.0, blendOutSpeed = 1.0, duration = 1500, flag = 31, playbackRate = 0.0 },
    { id = 'sarkastisk', label = 'Sarcastic Wave (R)', dict = 'ai_gestures@gen_female@standing@silent', name = 'silent_neutral_wave_r_001', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = 1500, flag = 31, playbackRate = 0.0 },
    { id = 'diskretvink', label = 'Discreet Wave (R)', dict = 'ai_gestures@gen_female@standing@silent', name = 'silent_flirty_greet_r_001', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = 1500, flag = 31, playbackRate = 0.0 },
    { id = 'smooth', label = 'Smooth Greet', dict = 'ai_gestures@arthur@standing@speaker@rt_hand', name = 'greet_cocky_l_003', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = 1000, flag = 31, playbackRate = 0.0 },
    { id = 'nik', label = 'Nod', dict = 'ai_gestures@gen_female@standing@silent', name = 'silent_neutral_greet_f_002', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = 1500, flag = 31, playbackRate = 0.0 },
    { id = 'cheer_male', label = 'Cheer (Male)', dict = 'ai_gestures@gen_male@standing@speaker@rt_hand@prop_rt', name = 'happy_cheer_f_001', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = 1500, flag = 31, playbackRate = 0.0 },
    { id = 'wave_female', label = 'Wave (Female)', dict = 'ai_gestures@gen_female@standing@speaker@lt_hand', name = 'happy_wave_fr_001', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = 1500, flag = 31, playbackRate = 0.0 },
    { id = 'silet_excited_cheer_r_001', label = 'Silent Excited Cheer (R)', dict = 'ai_gestures@gen_male@standing@silent@script@rt_hand@prop_rt', name = 'silent_excited_cheer_r_001', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = 1500, flag = 31, playbackRate = 0.0 },
    { id = 'mainhand_idle_vertical', category='Weapons', label = 'Rifle on Shoulder', dict = 'mech_doors@arms@rifle', name = 'mainhand_idle_vertical', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = -1, flag = 31, playbackRate = 0.0 },
    { id = 'aim_med_0', category='Weapons', label = 'Aim with Rifle high', dict = 'mech_weapons_longarms@air@base@sweep', name = 'aim_med_0', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = -1, flag = 31, playbackRate = 0.0 },
    -- mech_weapons_longarms@base@sweep_additives@block@aim@sweep_lf: block
    { id = 'block', category='Weapons', label = 'Hold Rifle in front of body', dict = 'mech_weapons_longarms@base@sweep_additives@block@aim@sweep_lf', name = 'block', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = -1, flag = 31, playbackRate = 0.0 },
    -- mech_weapons_longarms@base@sweep_ready@high: aim_med_0
    { id = 'aim_sweep_ready_high_med_0', category='Weapons', label = 'Aim with Rifle', dict = 'mech_weapons_longarms@base@sweep_ready@high', name = 'aim_med_0', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = -1, flag = 31, playbackRate = 0.0 },
    -- mech_weapons_longarms@base@sweep_ready@low: aim_med_0
    { id = 'aim_sweep_ready_low_med_0', category='Weapons', label = 'Hold Rifle Low', dict = 'mech_weapons_longarms@base@sweep_ready@low', name = 'aim_med_0', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = -1, flag = 31, playbackRate = 0.0 },
    { id = 'aim_sweep_pistol_med_0', category='Weapons', label = 'Aim with Pistol', dict = 'mech_weapons_core@base@sweep', name = 'aim_med_0', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = -1, flag = 31, playbackRate = 0.0 },
    { id = 'stand_arms_crossed', label = '[Standing] Arms Crossed', dict = 'script_amb@stores@store_arms_crossed_stoic', name = 'base', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = -1, flag = 31, playbackRate = 0.0 },
    { id = 'stand_waist', label = '[Standing] Waist', dict = 'script_amb@stores@store_waist_stern_guy', name = 'base', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = -1, flag = 31, playbackRate = 0.0 },
    { id = 'pee', label = 'Peeing', dict = 'amb_misc@world_human_pee@male_a@idle_b', name = 'idle_e', blendInSpeed = 1.0, blendOutSpeed = -1.0, duration = -1, flag = 31, playbackRate = 0.0 },
}



--
-- Context Menu: Examples for adding actions via config
--
-- This section demonstrates how to use the new registry-based dispatcher in
-- client/gm/context_menu.lua to register custom actions and add always-visible
-- default items dynamically.
--
-- Quick concepts:
-- - Each menu item must have an id and label. Optional data table is passed
--   to the handler when the item is clicked.
-- - Built-in actions (already registered in the script) typically expect
--   specific keys in data, such as:
--     data.coord (vector3), data.target (entity), data.ped, data.vehicle,
--     data.weapon (string), data.anim (table), data.scenario (handle)
-- - Custom actions you register can use any keys you define in data.
-- - Handlers receive two arguments: (data, meta)
--     data: the table provided on the menu item
--     meta: { actionId = string, context = lastContext }
--   meta.context mirrors the build context used for providers and includes
--   values like:
--     meta.context.ground (vector3 of last clicked ground position)
--     meta.context.selectionCount (number)
--     meta.context.targetPed (entity) when hovering a ped
--     meta.context.targetVehicle (entity) when hovering a vehicle
--
-- For novice developers: Start by copying one of the items below and change
-- the id/label and the code in the handler. You can add or remove fields in
-- the data table as you like for your custom actions.
--
-- External Action Registration:
-- You can also register actions from external scripts using the new exports:
--   - exports['dd_gamemaster']:RegisterGmAction(id, handler)
--   - exports['dd_gamemaster']:UnregisterGmAction(id)
--   - exports['dd_gamemaster']:RegisterGmActionPrefix(prefix, handler)
--   - exports['dd_gamemaster']:UnregisterGmActionPrefix(prefix)
--
-- Or via client events:
--   - TriggerEvent('gm:context_menu:register_action', id, handler)
--   - TriggerEvent('gm:context_menu:unregister_action', id)
--   - TriggerEvent('gm:context_menu:register_action_prefix', prefix, handler)
--   - TriggerEvent('gm:context_menu:unregister_action_prefix', prefix)
--
-- Example external script usage:
--   exports['dd_gamemaster']:RegisterGmAction('my_custom_action', function(data, meta)
--     print('My custom action triggered!')
--   end)

-- Guard to avoid re-registering on resource restarts
if not Config._ContextMenuExamplesRegistered then
    Config._ContextMenuExamplesRegistered = true

    CreateThread(function()
        -- Wait until the context menu module is available
        while not (GM and GM.ContextMenu and GM.ContextMenu.registerAction) do
            Wait(50)
        end
        local CM = GM.ContextMenu

        -- Example 1: A simple action that prints a message (appears only when right-clicking a ped)
        -- id: 'example_hello_world'
        -- data.message (string): optional text to display
        --CM.registerAction('example_hello_world', function(data, meta)
        --    local msg = (data and data.message) or 'Hello from Context Menu!'
        --    if Bridge and Bridge.Debug then
        --        Bridge.Debug('[GM] ' .. tostring(msg))
        --    end
        --end)

        -- Provider for Example 1:
        -- Adds the menu item only if the current right-click target is a ped
        --CM.register(function(ctx)
        --    local items = {}
        --    if ctx and ctx.targetPed and IsEntityAPed and IsEntityAPed(ctx.targetPed) then
        --        items[#items + 1] = {
        --            id = 'example_hello_world',
        --            label = 'Hello World',
        --            data = { message = 'Howdy!' }
        --        }
        --    end
        --    return items
        --end)

        -- Example 2: Operate on the current selection without requiring data
        -- id: 'example_stop_selected'
        -- No data fields are required. Applies to all selected peds.
        --CM.registerAction('example_stop_selected', function(_, _)
        --    if not (GM and GM.State and GM.State.selection) then return end
        --    for _, ent in ipairs(GM.State.selection) do
        --        if DoesEntityExist and DoesEntityExist(ent) and IsEntityAPed and IsEntityAPed(ent) then
        --            if ClearPedTasks then ClearPedTasks(ent) end
        --            if TaskStandStill then TaskStandStill(ent, -1) end
        --        end
        --    end
        --end)

        -- Example 3: Use meta.context (last click position) to move the selection
        -- id: 'example_goto_last_click'
        -- Uses meta.context.ground, so no data is required
        --CM.registerAction('example_goto_last_click', function(_, meta)
        --    local ctx = meta and meta.context
        --    if ctx and ctx.ground and GM and GM.Commands then
        --        GM.Commands.goToDirect(ctx.ground)
        --    end
        --end)

        -- Example 4: A prefix-based handler that echoes a message
        -- Any id starting with 'example_echo_' will be handled here.
        -- data.message (string): message to display
        --CM.registerActionPrefix('example_echo_', function(data, meta)
        --    local msg = (data and data.message) or tostring(meta and meta.actionId or 'example_echo_')
        --    if Bridge and Bridge.Debug then
        --        Bridge.Debug('[GM echo] ' .. tostring(msg))
        --    end
        --end)

        -- Example 5: External action registration example
        -- This demonstrates how an external script would register an action
        -- exports['dd_gamemaster']:RegisterGmAction('external_heal_player', function(data, meta)
        --     local targetPed = meta and meta.context and meta.context.targetPed
        --     if targetPed and DoesEntityExist(targetPed) then
        --         -- Heal the target ped (implement your healing logic here)
        --         if SetEntityHealth then SetEntityHealth(targetPed, GetEntityMaxHealth(targetPed)) end
        --         if Bridge and Bridge.Notification then
        --             Bridge.Notification('Player healed!', 'success')
        --         end
        --     end
        -- end)

        -- Provider for Example 5: Add the external action to context menus when right-clicking peds
        --CM.register(function(ctx)
        --    local items = {}
        --    if ctx and ctx.targetPed and IsEntityAPed and IsEntityAPed(ctx.targetPed) then
        --        items[#items + 1] = {
        --            id = 'external_heal_player',
        --            label = 'Heal Player (External)',
        --            data = {}
        --        }
        --    end
        --    return items
        --end)

        -- Add example default items (always shown at the bottom)
        -- You can remove these after reading or use them as a template.
        --CM.addDefaultItems({
        --    { id = 'example_stop_selected', label = 'Stop Selected', data = {} },
        --    { id = 'example_goto_last_click', label = 'Go To Last Click', data = {} },
        --    { id = 'example_echo_something', label = 'Echo: Something', data = { message = 'This will be echoed' } },
        --})

        -- Alternative: you can also set or add default items later from other scripts
        -- using the provided client events:
        -- TriggerEvent('gm:context_menu:add_default_items', { { id = 'example_hello_world', label = 'Hello (event)', data = { message = 'Sent from event' } } })
        -- TriggerEvent('gm:context_menu:set_default_items', { { id = 'example_stop_selected', label = 'Stop Selected (event)', data = {} } })
    end)
end
