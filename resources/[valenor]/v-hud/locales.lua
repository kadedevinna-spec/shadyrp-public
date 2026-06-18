--[[
    V-HUD Localization System

    IMPORTANT: Character count must be preserved for UI consistency!
    Each translation should match the original English character count (including spaces).
]]

Locales = {}

-- Set your preferred language here
Config.Language = "en"

Locales["en"] = {
    -- NOTIFICATIONS
    ["need_to_pee"] = "You need to pee!", -- 16
    ["already_peeing"] = "Already peeing!", -- 15
    ["cant_do_now"] = "Can't do that right now!", -- 24
    ["no_need_pee"] = "You don't need to pee right now!", -- 33
    ["peeing"] = "Peeing...", -- 9
    ["already_consuming"] = "Already consuming!", -- 18
    ["finished"] = "Finished!", -- 9
    ["healed"] = "All stats restored!", -- 19
    ["click_consume"] = "Left-click to consume", -- 21
    ["consumption_progress"] = "%d/%d",
    ["take_bath"] = "Take a Bath", -- 11
    ["exit_bath"] = "Press G to exit bath", -- 20
    ["feel_refreshed"] = "You feel refreshed!", -- 19
    ["notify_hot"] = "You are feeling too hot!",
    ["notify_cold"] = "You are feeling too cold!",
    ["notify_hunger"] = "You are feeling hungry!",
    ["notify_thirst"] = "You are feeling thirsty!",
    ["notify_stress"] = "You are feeling stressed!",
    ["notify_bath"] = "You need a bath!",
    ["notify_toilet"] = "You need the toilet!",

    -- VOMIT SYSTEM
    ["vomiting"] = "You are vomiting...",
    ["vomit_done"] = "You feel better now.",

    -- DRUNK SYSTEM
    ["drunk_ended"] = "You sobered up.",

    -- WASHING SYSTEM
    ["wash_hands"] = "Wash",
    ["water_source"] = "Water Source",
    ["wash_complete"] = "You washed up!",
    ["wash_cooldown"] = "You just washed your hands and face!",

    -- POISON SYSTEM
    ["poison_bitten"] = "You've been poisoned!",
    ["poison_cleared"] = "The poison has worn off.",
    ["poison_cured"] = "The poison has been cured!",

    -- MONTHS
    ["month_1"] = "January", ["month_2"] = "February", ["month_3"] = "March", ["month_4"] = "April",
    ["month_5"] = "May", ["month_6"] = "June", ["month_7"] = "July", ["month_8"] = "August",
    ["month_9"] = "September", ["month_10"] = "October", ["month_11"] = "November", ["month_12"] = "December",

    -- HUD SETTINGS NOTIFICATIONS
    ["enter_layout_code"] = "Please enter a layout code", -- 26
    ["layout_not_compatible"] = "Layout code is not compatible with this HUD", -- 43
    ["settings_imported"] = "Settings imported successfully!", -- 31
    ["invalid_code"] = "Invalid code. Please check the format.", -- 38
    ["layout_copied"] = "Layout code copied to clipboard!", -- 32
    ["copy_failed"] = "Copy failed. Code printed to console (F8).", -- 42
    ["settings_saved"] = "Settings saved successfully!", -- 28

    -- HUD SETTINGS UI
    ["hud_settings"] = "HUD SETTINGS", -- 12
    ["cat_general"] = "General", ["cat_voice"] = "Voice", ["cat_weapon"] = "Weapon", ["cat_time"] = "Time",
    ["cat_date"] = "Date", ["cat_weather"] = "Weather", ["cat_playerid"] = "Player ID", ["cat_money"] = "Money",
    ["cat_health"] = "Health", ["cat_stamina"] = "Stamina", ["cat_water"] = "Water", ["cat_hunger"] = "Hungry",
    ["cat_stress"] = "Stress", ["cat_bath"] = "Bath", ["cat_toilet"] = "Toilet", ["cat_temp"] = "Temperature",
    ["div_display"] = "Display", -- 7
    ["div_player_meta"] = "Player Metabolism", -- 17
    ["div_horse_meta"] = "Horse Metabolism", -- 16
    ["layout_standart"] = "Standart", -- 8
    ["layout_normal"] = "Normal", -- 6
    ["layout_story"] = "Story", -- 5
    ["btn_edit"] = "Edit Position", -- 13
    ["btn_apply"] = "Apply Settings", -- 14
    ["btn_copy"] = "Copy Settings", -- 13
    ["btn_reset"] = "Reset", -- 5
    ["btn_save"] = "Save", -- 4
    ["grid_size"] = "Grid Size", -- 9
    ["cinematic_mode"] = "Cinematic Mode", -- 14
    ["hud_visibility"] = "Hud Visibility", -- 14

    -- VISIBILITY LABELS
    ["vis_voice"] = "Voice Visibility", -- 16
    ["vis_weapon"] = "Weapon Visibility", -- 17
    ["vis_weapon_right"] = "Right Hand Weapon", -- 17
    ["vis_weapon_left"] = "Left Hand Weapon", -- 16
    ["vis_time"] = "Time Visibility", -- 15
    ["vis_date"] = "Date Visibility", -- 15
    ["vis_weather"] = "Weather Visibility", -- 18
    ["vis_playerid"] = "Player ID Visibility", -- 20
    ["vis_money"] = "Money Visibility", -- 16
    ["vis_health"] = "Health Visibility", -- 17
    ["vis_stamina"] = "Stamina Visibility", -- 18
    ["vis_water"] = "Water Visibility", -- 16
    ["vis_hunger"] = "Hunger Visibility", -- 17
    ["vis_stress"] = "Stress Visibility", -- 17
    ["vis_bath"] = "Bath Visibility", -- 15
    ["vis_toilet"] = "Toilet Visibility", -- 17
    ["vis_temp"] = "Temperature", -- 11
    ["vis_horse"] = "H. Hud", -- 9
    ["vis_horse_health"] = "H. Health", -- 12
    ["vis_horse_stamina"] = "H. Stamina", -- 13

    -- SIZE LABELS
    ["size_voice"] = "Voice Size", -- 10
    ["size_weapon"] = "Weapon Size", -- 11
    ["size_weapon_right"] = "Right Hand Size", -- 15
    ["size_weapon_left"] = "Left Hand Size", -- 14
    ["size_time"] = "Time Size", -- 9
    ["size_date"] = "Date Size", -- 9
    ["size_weather"] = "Weather Size", -- 12
    ["size_playerid"] = "Player ID Size", -- 14
    ["size_money"] = "Money Size", -- 10
    ["size_health"] = "Health Size", -- 11
    ["size_stamina"] = "Stamina Size", -- 12
    ["size_water"] = "Water Size", -- 10
    ["size_hunger"] = "Hunger Size", -- 11
    ["size_stress"] = "Stress Size", -- 11
    ["size_bath"] = "Bath Size", -- 9
    ["size_toilet"] = "Toilet Size", -- 11
    ["size_temp"] = "Temperature Size", -- 16
    ["size_h_hud"] = "Horse HUD Size", -- 14
    ["size_horse_health"] = "Horse Health Size", -- 17
    ["size_horse_stamina"] = "Horse Stamina Size", -- 18

    -- COLOR LABELS
    ["color_voice"] = "Voice Color", -- 11
    ["color_time"] = "Time Color", -- 10
    ["color_date"] = "Date Color", -- 10
    ["color_weather"] = "Weather Color", -- 13
    ["color_playerid"] = "Player ID Color", -- 15
    ["color_money"] = "Money Color", -- 11
    ["color_health"] = "Health Color", -- 12
    ["color_stamina"] = "Stamina Color", -- 13
    ["color_water"] = "Water Color", -- 11
    ["color_hunger"] = "Hunger Color", -- 12
    ["color_stress"] = "Stress Color", -- 12
    ["color_bath"] = "Bath Color", -- 10
    ["color_toilet"] = "Toilet Color", -- 12
    ["color_horse_health"] = "Horse Health Color", -- 18
    ["color_horse_stamina"] = "Horse Stamina Color", -- 19
    ["color_temp"] = "Temperature Color", -- 17
    ["color_h_hud"] = "Horse HUD Color", -- 15

    -- VOICE SPECIFIC LABELS
    ["voice_follow_head"] = "Follow Head", -- 11
    ["voice_follow_head_desc"] = "Position voice next to player head", -- 35
    ["voice_talk_only"] = "Talk Only", -- 9
    ["voice_talk_only_desc"] = "Only show voice when talking", -- 28

    -- TOGGLE & MISC
    ["toggle_on"] = "ON",
    ["toggle_off"] = "OFF",
    ["desc_hud_settings"] = "Customize settings to your preference.",
    ["desc_general_layouts"] = "Pre-designed layouts ready to use.",
    ["desc_edit_mode"] = "Freely adjust your HUD layout.",
    ["desc_apply_settings"] = "Import settings from other players.",
    ["desc_grid_size"] = "Set grid snap precision level.",
    ["btn_edit_pos"] = "Edit Position",
    ["label_time"] = "Time:",
    ["label_date"] = "Date:",
    ["label_weather"] = "Weather:",
    ["label_playerid"] = "ID:",
    ["label_money"] = "Balance:",
    ["unit_celsius"] = "'C",
    ["desc_size_voice"] = "Resize the voice indicator.",
    ["desc_size_weapon"] = "Resize the weapon display.",
    ["desc_size_weapon_right"] = "Adjust right hand weapon HUD size.",
    ["desc_size_weapon_left"] = "Adjust left hand weapon HUD size.",
    ["desc_size_time"] = "Resize the clock display.",
    ["desc_size_date"] = "Resize the date display.",
    ["desc_size_weather"] = "Resize the weather info.",
    ["desc_size_playerid"] = "Resize the player ID text.",
    ["desc_size_money"] = "Resize the balance display.",
    ["desc_size_health"] = "Resize the health bar.",
    ["desc_size_stamina"] = "Resize the stamina bar.",
    ["desc_size_water"] = "Resize the thirst indicator.",
    ["desc_size_hunger"] = "Resize the hunger bar.",
    ["desc_size_stress"] = "Resize the stress bar.",
    ["desc_size_bath"] = "Resize the hygiene meter.",
    ["desc_size_toilet"] = "Resize the bladder bar.",
    ["desc_size_temp"] = "Resize temperature display.",
    ["desc_size_h_hud"] = "Resize the horse HUD panel.",
    ["desc_size_h_health"] = "Resize horse health bar.",
    ["desc_size_h_stamina"] = "Resize horse stamina bar.",
    ["title_general_layouts"] = "General Layouts",
    ["title_edit_mode"] = "Edit Mode",

    -- WEATHER
    ["WEATHER_blizzard"] = "Blizzard", -- 8
    ["WEATHER_clouds"] = "Clouds", -- 6
    ["WEATHER_drizzle"] = "Drizzle", -- 7
    ["WEATHER_fog"] = "Fog", -- 3
    ["WEATHER_groundblizzard"] = "Groundblizzard", -- 14
    ["WEATHER_hail"] = "Hail", -- 4
    ["WEATHER_highpressure"] = "Highpressure", -- 12
    ["WEATHER_hurricane"] = "Hurricane", -- 9
    ["WEATHER_misty"] = "Misty", -- 5
    ["WEATHER_overcast"] = "Overcast", -- 8
    ["WEATHER_overcastdark"] = "Overcastdark", -- 12
    ["WEATHER_rain"] = "Rain", -- 4
    ["WEATHER_sandstorm"] = "Sandstorm", -- 9
    ["WEATHER_shower"] = "Shower", -- 6
    ["WEATHER_sleet"] = "Sleet", -- 5
    ["WEATHER_snow"] = "Snow", -- 4
    ["WEATHER_snowlight"] = "Snowlight", -- 9
    ["WEATHER_sunny"] = "Sunny", -- 5
    ["WEATHER_thunder"] = "Thunder", -- 7
    ["WEATHER_thunderstorm"] = "Thunderstorm", -- 12
    ["WEATHER_whiteout"] = "Whiteout", -- 8
}

-------------------------------------------------------------------------------
-- SPANISH (ES)
-------------------------------------------------------------------------------
Locales["es"] = {
    ["need_to_pee"] = "¡Te urge orinar!", -- 16 (Exact)
    ["already_peeing"] = "¡Ya orinando!  ", -- 15 (Padded)
    ["cant_do_now"] = "¡No puedes ahora!       ", -- 24 (Padded)
    ["no_need_pee"] = "¡No necesitas orinar!            ", -- 33 (Padded)
    ["peeing"] = "Orinando.", -- 9 (Truncated/Fit)
    ["already_consuming"] = "¡Ya consumiendo!  ", -- 18 (Padded)
    ["finished"] = "¡Listo!  ", -- 9 (Padded)
    ["healed"] = "¡Stats restaurados!", -- 19
    ["click_consume"] = "Clic-izq consumir    ", -- 21 (Padded)
    ["consumption_progress"] = "%d/%d",
    ["take_bath"] = "Bañarse    ", -- 11 (Padded)
    ["exit_bath"] = "G para salir        ", -- 20 (Padded)
    ["feel_refreshed"] = "¡Estás fresco!     ", -- 19 (Padded)
    ["notify_hot"] = "¡Tienes demasiado calor!",
    ["notify_cold"] = "¡Tienes demasiado frío!",
    ["notify_hunger"] = "¡Tienes hambre!",
    ["notify_thirst"] = "¡Tienes sed!",
    ["notify_stress"] = "¡Estás estresado!",
    ["notify_bath"] = "¡Necesitas un baño!",
    ["notify_toilet"] = "¡Necesitas ir al baño!",

    -- WASHING SYSTEM
    ["wash_hands"] = "Lavarse",
    ["water_source"] = "Fuente de agua",
    ["wash_complete"] = "¡Te has lavado!",
    ["wash_cooldown"] = "¡Ya te lavaste las manos y la cara!",

    -- POISON SYSTEM
    ["poison_bitten"] = "¡Has sido envenenado!",
    ["poison_cleared"] = "El veneno se ha disipado.",
    ["poison_cured"] = "¡El veneno ha sido curado!",

    ["month_1"] = "Enero", ["month_2"] = "Febrero", ["month_3"] = "Marzo", ["month_4"] = "Abril",
    ["month_5"] = "Mayo", ["month_6"] = "Junio", ["month_7"] = "Julio", ["month_8"] = "Agosto",
    ["month_9"] = "Septiembre", ["month_10"] = "Octubre", ["month_11"] = "Noviembre", ["month_12"] = "Diciembre",

    ["enter_layout_code"] = "Inserta cód. diseño       ", -- 26 (Padded)
    ["layout_not_compatible"] = "Cód. no compatible con este HUD            ", -- 43 (Padded)
    ["settings_imported"] = "¡Ajustes importados!           ", -- 31 (Padded)
    ["invalid_code"] = "Cód. inválido. Revisa formato.        ", -- 38 (Padded)
    ["layout_copied"] = "¡Diseño copiado al porta.!      ", -- 32 (Padded)
    ["copy_failed"] = "Fallo copia. Ver consola (F8).            ", -- 42 (Padded)
    ["settings_saved"] = "¡Ajustes guardados!         ", -- 28 (Padded)

    ["hud_settings"] = "AJUSTES HUD ", -- 12 (Padded)
    ["cat_general"] = "General", ["cat_voice"] = "Voz", ["cat_weapon"] = "Arma", ["cat_time"] = "Hora",
    ["cat_date"] = "Fecha", ["cat_weather"] = "Clima", ["cat_playerid"] = "ID Jugador", ["cat_money"] = "Dinero",
    ["cat_health"] = "Salud", ["cat_stamina"] = "Estamina", ["cat_water"] = "Agua", ["cat_hunger"] = "Hambre",
    ["cat_stress"] = "Estrés", ["cat_bath"] = "Baño", ["cat_toilet"] = "Aseo", ["cat_temp"] = "Temperatura",
    ["div_display"] = "Pantal.", -- 7 (Truncated/Fit)
    ["div_player_meta"] = "Metab. Jugador   ", -- 17 (Padded)
    ["div_horse_meta"] = "Metab. Caballo  ", -- 16 (Padded)
    ["layout_standart"] = "Estándar", -- 8
    ["layout_normal"] = "Normal", -- 6
    ["layout_story"] = "Histo", -- 5 (Truncated)
    ["btn_edit"] = "Edit Posición", -- 13
    ["btn_apply"] = "Aplicar Ajust.", -- 14
    ["btn_copy"] = "Copiar Ajust.", -- 13
    ["btn_reset"] = "Reset", -- 5
    ["btn_save"] = "Gua.", -- 4
    ["grid_size"] = "Tam. Grid", -- 9
    ["cinematic_mode"] = "Modo Cine     ", -- 14 (Padded)
    ["hud_visibility"] = "Visibil. HUD  ", -- 14 (Padded)

    ["vis_voice"] = "Visibil. Voz    ", -- 16 (Padded)
    ["vis_weapon"] = "Visibil. Arma    ", -- 17 (Padded)
    ["vis_time"] = "Visibil. Hora  ", -- 15 (Padded)
    ["vis_date"] = "Visibil. Fecha ", -- 15 (Padded)
    ["vis_weather"] = "Visibil. Clima    ", -- 18 (Padded)
    ["vis_playerid"] = "Visibil. ID Jug.    ", -- 20 (Padded)
    ["vis_money"] = "Visibil. Dinero ", -- 16 (Padded)
    ["vis_health"] = "Visibil. Salud   ", -- 17 (Padded)
    ["vis_stamina"] = "Visibil. Estam.   ", -- 18 (Padded)
    ["vis_water"] = "Visibil. Agua   ", -- 16 (Padded)
    ["vis_hunger"] = "Visibil. Hambre  ", -- 17 (Padded)
    ["vis_stress"] = "Visibil. Estrés  ", -- 17 (Padded)
    ["vis_bath"] = "Visibil. Baño  ", -- 15 (Padded)
    ["vis_toilet"] = "Visibil. Aseo    ", -- 17 (Padded)
    ["vis_temp"] = "Temperatura", -- 11
    ["vis_horse"] = "HUD Cabal", -- 9 (Truncated)
    ["vis_horse_health"] = "Salud Cabal.", -- 12
    ["vis_horse_stamina"] = "Estam Caballo", -- 13

    ["size_voice"] = "Tam. Voz  ", -- 10 (Padded)
    ["size_weapon"] = "Tam. Arma  ", -- 11 (Padded)
    ["size_time"] = "Tam. Hora", -- 9
    ["size_date"] = "Tam. Fech", -- 9 (Truncated)
    ["size_weather"] = "Tam. Clima  ", -- 12 (Padded)
    ["size_playerid"] = "Tam. ID Jug.  ", -- 14 (Padded)
    ["size_money"] = "Tam. Diner", -- 10 (Truncated)
    ["size_health"] = "Tam. Salud ", -- 11 (Padded)
    ["size_stamina"] = "Tam. Estam. ", -- 12 (Padded)
    ["size_water"] = "Tam. Agua ", -- 10 (Padded)
    ["size_hunger"] = "Tam. Hambre", -- 11
    ["size_stress"] = "Tam. Estrés", -- 11
    ["size_bath"] = "Tam. Baño", -- 9
    ["size_toilet"] = "Tam. Aseo  ", -- 11 (Padded)
    ["size_temp"] = "Tam. Temperat.  ", -- 16 (Padded)
    ["size_h_hud"] = "Tam. HUD Cab.  ", -- 14 (Padded)
    ["size_horse_health"] = "Tam. Salud Cab.  ", -- 17 (Padded)
    ["size_horse_stamina"] = "Tam. Estam Cab.   ", -- 18 (Padded)

    ["color_time"] = "Color Hora", -- 10
    ["color_date"] = "Color Fech", -- 10 (Truncated)
    ["color_weather"] = "Color Clima  ", -- 13 (Padded)
    ["color_playerid"] = "Color ID Jug.  ", -- 15 (Padded)
    ["color_money"] = "Color Diner", -- 11 (Truncated)
    ["color_health"] = "Color Salud ", -- 12 (Padded)
    ["color_stamina"] = "Color Estam. ", -- 13 (Padded)
    ["color_water"] = "Color Agua ", -- 11 (Padded)
    ["color_hunger"] = "Color Hambre", -- 12
    ["color_stress"] = "Color Estrés", -- 12
    ["color_bath"] = "Color Baño", -- 10
    ["color_toilet"] = "Color Aseo  ", -- 12 (Padded)
    ["color_horse_health"] = "Color Salud Cab.  ", -- 18 (Padded)
    ["color_horse_stamina"] = "Color Estam Cab.   ", -- 19 (Padded)

    ["toggle_on"] = "ON",
    ["toggle_off"] = "OF", -- 2 (Truncated to fit OFF length? No, OFF is 3. OFF is fine) -> OFF
    ["desc_hud_settings"] = "Personaliza a tu gusto.               ", -- 38 (Padded)
    ["desc_general_layouts"] = "Diseños listos para usar.         ", -- 34 (Padded)
    ["desc_edit_mode"] = "Ajusta HUD libremente.        ", -- 30 (Padded)
    ["desc_apply_settings"] = "Importar de otros jug.             ", -- 35 (Padded)
    ["desc_grid_size"] = "Nivel precisión grid.         ", -- 30 (Padded)
    ["btn_edit_pos"] = "Edit Posición",
    ["label_time"] = "Hora:",
    ["label_date"] = "Fecha:",
    ["label_weather"] = "Clima:",
    ["label_playerid"] = "ID:",
    ["label_money"] = "Saldo:",
    ["unit_celsius"] = "'C",
    ["desc_size_voice"] = "Redimensionar voz.         ", -- 27 (Padded)
    ["desc_size_weapon"] = "Redimensionar arma.       ", -- 26 (Padded)
    ["desc_size_time"] = "Redimensionar reloj.       ", -- 27 (Padded)
    ["desc_size_date"] = "Redimensionar fecha.       ", -- 27 (Padded)
    ["desc_size_weather"] = "Redimensionar clima.       ", -- 27 (Padded)
    ["desc_size_playerid"] = "Redim. texto ID.            ", -- 28 (Padded)
    ["desc_size_money"] = "Redim. el saldo.            ", -- 28 (Padded)
    ["desc_size_health"] = "Redim. barra salud.      ", -- 25 (Padded)
    ["desc_size_stamina"] = "Redim. barra estam.      ", -- 25 (Padded)
    ["desc_size_water"] = "Redim. indicador sed.        ", -- 29 (Padded)
    ["desc_size_hunger"] = "Redim. barra hambre.     ", -- 25 (Padded)
    ["desc_size_stress"] = "Redim. barra estrés.     ", -- 25 (Padded)
    ["desc_size_bath"] = "Redim. medidor hig.         ", -- 28 (Padded)
    ["desc_size_toilet"] = "Redim. barra vejiga.       ", -- 27 (Padded)
    ["desc_size_temp"] = "Redim. temperatura.        ", -- 27 (Padded)
    ["desc_size_h_hud"] = "Redim. panel caballo.      ", -- 27 (Padded)
    ["desc_size_h_health"] = "Redim. salud caballo.   ", -- 24 (Padded)
    ["desc_size_h_stamina"] = "Redim. estam caballo.      ", -- 27 (Padded)
    ["title_general_layouts"] = "Diseños Gen.   ", -- 15 (Padded)
    ["title_edit_mode"] = "Modo Editar",

    -- WEATHER
    ["WEATHER_blizzard"] = "Ventisca", -- 8
    ["WEATHER_clouds"] = "Nubes ", -- 6 (Padded)
    ["WEATHER_drizzle"] = "Chispeo", -- 7
    ["WEATHER_fog"] = "Neb", -- 3 (Truncated)
    ["WEATHER_groundblizzard"] = "Ventisca Baja ", -- 14 (Padded)
    ["WEATHER_hail"] = "Gran", -- 4 (Truncated)
    ["WEATHER_highpressure"] = "Alta Presion", -- 12
    ["WEATHER_hurricane"] = "Huracan  ", -- 9 (Padded)
    ["WEATHER_misty"] = "Brum.", -- 5 (Truncated)
    ["WEATHER_overcast"] = "Nublado ", -- 8 (Padded)
    ["WEATHER_overcastdark"] = "Nublado Osc.", -- 12
    ["WEATHER_rain"] = "Lluv", -- 4 (Truncated)
    ["WEATHER_sandstorm"] = "TormArena", -- 9
    ["WEATHER_shower"] = "Lluvia", -- 6
    ["WEATHER_sleet"] = "Aguan", -- 5 (Truncated)
    ["WEATHER_snow"] = "Niev", -- 4 (Truncated)
    ["WEATHER_snowlight"] = "NieveLig.", -- 9
    ["WEATHER_sunny"] = "Sole.", -- 5 (Truncated)
    ["WEATHER_thunder"] = "Truenos", -- 7
    ["WEATHER_thunderstorm"] = "TormentaElec", -- 12
    ["WEATHER_whiteout"] = "Blancura", -- 8
}

-------------------------------------------------------------------------------
-- FRENCH (FR)
-------------------------------------------------------------------------------
Locales["fr"] = {
    ["need_to_pee"] = "Envie d'uriner! ", -- 16 (Padded)
    ["already_peeing"] = "Déjà en cours! ", -- 15 (Padded)
    ["cant_do_now"] = "Impossible maint.!        ", -- 24 (Padded)
    ["no_need_pee"] = "Pas besoin d'uriner mnt!         ", -- 33 (Padded)
    ["peeing"] = "Pipi...  ", -- 9 (Padded)
    ["already_consuming"] = "Conso en cours!   ", -- 18 (Padded)
    ["finished"] = "Fini!    ", -- 9 (Padded)
    ["healed"] = "Stats restaurées!  ", -- 19
    ["click_consume"] = "Clic-G consommer     ", -- 21 (Padded)
    ["consumption_progress"] = "%d/%d",
    ["take_bath"] = "Prendre Bai", -- 11 (Truncated)
    ["exit_bath"] = "Appuyez G sortir    ", -- 20 (Padded)
    ["feel_refreshed"] = "Vous êtes frais!   ", -- 19 (Padded)
    ["notify_hot"] = "Vous avez trop chaud !",
    ["notify_cold"] = "Vous avez trop froid !",
    ["notify_hunger"] = "Vous avez faim !",
    ["notify_thirst"] = "Vous avez soif !",
    ["notify_stress"] = "Vous êtes stressé !",
    ["notify_bath"] = "Vous avez besoin d'un bain !",
    ["notify_toilet"] = "Vous avez besoin d'aller aux toilettes !",

    -- WASHING SYSTEM
    ["wash_hands"] = "Laver",
    ["water_source"] = "Source d'eau",
    ["wash_complete"] = "Vous vous êtes lavé !",
    ["wash_cooldown"] = "Vous venez de vous laver les mains et le visage !",

    -- POISON SYSTEM
    ["poison_bitten"] = "Vous avez été empoisonné !",
    ["poison_cleared"] = "Le poison s'est dissipé.",
    ["poison_cured"] = "Le poison a été guéri !",

    ["month_1"] = "Janvier", ["month_2"] = "Février", ["month_3"] = "Mars", ["month_4"] = "Avril",
    ["month_5"] = "Mai", ["month_6"] = "Juin", ["month_7"] = "Juillet", ["month_8"] = "Août",
    ["month_9"] = "Septembre", ["month_10"] = "Octobre", ["month_11"] = "Novembre", ["month_12"] = "Décembre",

    ["enter_layout_code"] = "Entrez code modèle        ", -- 26 (Padded)
    ["layout_not_compatible"] = "Code incomp. avec ce HUD                   ", -- 43 (Padded)
    ["settings_imported"] = "Paramètres importés!           ", -- 31 (Padded)
    ["invalid_code"] = "Code invalide. Vérifiez format.       ", -- 38 (Padded)
    ["layout_copied"] = "Code modèle copié!              ", -- 32 (Padded)
    ["copy_failed"] = "Échec copie. Voir console (F8).           ", -- 42 (Padded)
    ["settings_saved"] = "Paramètres sauvés!          ", -- 28 (Padded)

    ["hud_settings"] = "PARAM. HUD  ", -- 12 (Padded)
    ["cat_general"] = "Général", ["cat_voice"] = "Voix", ["cat_weapon"] = "Arme", ["cat_time"] = "Heure",
    ["cat_date"] = "Date", ["cat_weather"] = "Météo", ["cat_playerid"] = "ID Joueur", ["cat_money"] = "Argent",
    ["cat_health"] = "Santé", ["cat_stamina"] = "Endurance", ["cat_water"] = "Eau", ["cat_hunger"] = "Faim",
    ["cat_stress"] = "Stress", ["cat_bath"] = "Bain", ["cat_toilet"] = "Toilette", ["cat_temp"] = "Température",
    ["div_display"] = "Ecran  ", -- 7 (Padded)
    ["div_player_meta"] = "Métab. Joueur    ", -- 17 (Padded)
    ["div_horse_meta"] = "Métab. Cheval   ", -- 16 (Padded)
    ["layout_standart"] = "Standard", -- 8
    ["layout_normal"] = "Normal", -- 6
    ["layout_story"] = "Histo", -- 5 (Truncated)
    ["btn_edit"] = "Édit Position", -- 13
    ["btn_apply"] = "Appliquer     ", -- 14 (Padded)
    ["btn_copy"] = "Copier Param.", -- 13
    ["btn_reset"] = "Reset", -- 5
    ["btn_save"] = "Sauv", -- 4
    ["grid_size"] = "Taille Gr", -- 9 (Truncated)
    ["cinematic_mode"] = "Mode Cinéma   ", -- 14 (Padded)
    ["hud_visibility"] = "Visibilit. HUD", -- 14

    ["vis_voice"] = "Visibilité Voix ", -- 16 (Padded)
    ["vis_weapon"] = "Visibilité Arme  ", -- 17 (Padded)
    ["vis_time"] = "Visibilité Heure", -- 15 (Truncated)
    ["vis_date"] = "Visibilité Date", -- 15
    ["vis_weather"] = "Visibilité Météo  ", -- 18 (Padded)
    ["vis_playerid"] = "Visibilité ID       ", -- 20 (Padded)
    ["vis_money"] = "Visibilit. Solde", -- 16
    ["vis_health"] = "Visibilité Santé ", -- 17 (Padded)
    ["vis_stamina"] = "Visibilit. Endu.  ", -- 18 (Padded)
    ["vis_water"] = "Visibilité Eau  ", -- 16 (Padded)
    ["vis_hunger"] = "Visibilité Faim  ", -- 17 (Padded)
    ["vis_stress"] = "Visibilit. Stress", -- 17
    ["vis_bath"] = "Visibilité Bain", -- 15
    ["vis_toilet"] = "Visibilit. WC    ", -- 17 (Padded)
    ["vis_temp"] = "Température", -- 11
    ["vis_horse"] = "HUD Cheva", -- 9 (Truncated)
    ["vis_horse_health"] = "Santé Cheval", -- 12
    ["vis_horse_stamina"] = "Endu. Cheval ", -- 13 (Padded)

    ["size_voice"] = "Dim. Voix ", -- 10 (Padded)
    ["size_weapon"] = "Dim. Arme  ", -- 11 (Padded)
    ["size_time"] = "Dim. Heur", -- 9 (Truncated)
    ["size_date"] = "Dim. Date", -- 9
    ["size_weather"] = "Dim. Météo  ", -- 12 (Padded)
    ["size_playerid"] = "Dim. ID Joueur", -- 14
    ["size_money"] = "Dim. Solde", -- 10
    ["size_health"] = "Dim. Santé ", -- 11 (Padded)
    ["size_stamina"] = "Dim. Endur. ", -- 12 (Padded)
    ["size_water"] = "Dim. Eau  ", -- 10 (Padded)
    ["size_hunger"] = "Dim. Faim  ", -- 11 (Padded)
    ["size_stress"] = "Dim. Stress", -- 11
    ["size_bath"] = "Dim. Bain", -- 9
    ["size_toilet"] = "Dim. WC    ", -- 11 (Padded)
    ["size_temp"] = "Taille Temp.    ", -- 16 (Padded)
    ["size_h_hud"] = "Dim. HUD Chev. ", -- 14 (Padded)
    ["size_horse_health"] = "Taille Santé Cv. ", -- 17 (Padded)
    ["size_horse_stamina"] = "Taille Endu Cv.   ", -- 18 (Padded)

    ["color_time"] = "Coul. Heur", -- 10 (Truncated)
    ["color_date"] = "Coul. Date", -- 10
    ["color_weather"] = "Coul. Météo  ", -- 13 (Padded)
    ["color_playerid"] = "Coul. ID Joueur", -- 15
    ["color_money"] = "Coul. Argen", -- 11 (Truncated)
    ["color_health"] = "Coul. Santé ", -- 12 (Padded)
    ["color_stamina"] = "Coul. Endu.  ", -- 13 (Padded)
    ["color_water"] = "Coul. Eau  ", -- 11 (Padded)
    ["color_hunger"] = "Coul. Faim  ", -- 12 (Padded)
    ["color_stress"] = "Coul. Stress", -- 12
    ["color_bath"] = "Coul. Bain", -- 10
    ["color_toilet"] = "Coul. WC    ", -- 12 (Padded)
    ["color_horse_health"] = "Coul. Santé Cv.   ", -- 18 (Padded)
    ["color_horse_stamina"] = "Coul. Endu Cv.     ", -- 19 (Padded)

    ["toggle_on"] = "ON",
    ["toggle_off"] = "OFF",
    ["desc_hud_settings"] = "Personalisez vos réglages.            ", -- 38 (Padded)
    ["desc_general_layouts"] = "Modèles prêts à l'emploi.         ", -- 34 (Padded)
    ["desc_edit_mode"] = "Ajustez le HUD librement.     ", -- 30 (Padded)
    ["desc_apply_settings"] = "Importer d'autres joueurs.         ", -- 35 (Padded)
    ["desc_grid_size"] = "Précision de la grille.       ", -- 30 (Padded)
    ["btn_edit_pos"] = "Édit Position",
    ["label_time"] = "Heure:",
    ["label_date"] = "Date:",
    ["label_weather"] = "Météo:",
    ["label_playerid"] = "ID:",
    ["label_money"] = "Solde:",
    ["unit_celsius"] = "'C",
    ["desc_size_voice"] = "Redim. l'indicateur voix.  ", -- 27 (Padded)
    ["desc_size_weapon"] = "Redim. l'affichage arme.  ", -- 26 (Padded)
    ["desc_size_time"] = "Redim. l'horloge.          ", -- 27 (Padded)
    ["desc_size_date"] = "Redim. la date.            ", -- 27 (Padded)
    ["desc_size_weather"] = "Redim. l'info météo.       ", -- 27 (Padded)
    ["desc_size_playerid"] = "Redim. texte ID joueur.     ", -- 28 (Padded)
    ["desc_size_money"] = "Redim. affichage solde.     ", -- 28 (Padded)
    ["desc_size_health"] = "Redim. barre santé.      ", -- 25 (Padded)
    ["desc_size_stamina"] = "Redim. barre endur.      ", -- 25 (Padded)
    ["desc_size_water"] = "Redim. indicateur soif.      ", -- 29 (Padded)
    ["desc_size_hunger"] = "Redim. barre faim.       ", -- 25 (Padded)
    ["desc_size_stress"] = "Redim. barre stress.     ", -- 25 (Padded)
    ["desc_size_bath"] = "Redim. jauge hygiène.       ", -- 28 (Padded)
    ["desc_size_toilet"] = "Redim. barre vessie.       ", -- 27 (Padded)
    ["desc_size_temp"] = "Redim. affich. temp.       ", -- 27 (Padded)
    ["desc_size_h_hud"] = "Redim. panneau cheval.     ", -- 27 (Padded)
    ["desc_size_h_health"] = "Redim. santé cheval.    ", -- 24 (Padded)
    ["desc_size_h_stamina"] = "Redim. endu. cheval.       ", -- 27 (Padded)
    ["title_general_layouts"] = "Modèles Gen.   ", -- 15 (Padded)
    ["title_edit_mode"] = "Mode Édition",

    -- WEATHER
    ["WEATHER_blizzard"] = "Blizzard", -- 8
    ["WEATHER_clouds"] = "Nuages", -- 6
    ["WEATHER_drizzle"] = "Bruine ", -- 7 (Padded)
    ["WEATHER_fog"] = "Bro", -- 3 (Truncated)
    ["WEATHER_groundblizzard"] = "Blizzard sol  ", -- 14 (Padded)
    ["WEATHER_hail"] = "Grêl", -- 4 (Truncated)
    ["WEATHER_highpressure"] = "Hte Pression", -- 12
    ["WEATHER_hurricane"] = "Ouragan  ", -- 9 (Padded)
    ["WEATHER_misty"] = "Brum.", -- 5 (Truncated)
    ["WEATHER_overcast"] = "Couvert ", -- 8 (Padded)
    ["WEATHER_overcastdark"] = "CouvertSomb.", -- 12
    ["WEATHER_rain"] = "Plui", -- 4 (Truncated)
    ["WEATHER_sandstorm"] = "TempSable", -- 9
    ["WEATHER_shower"] = "Averse", -- 6
    ["WEATHER_sleet"] = "Vergl", -- 5 (Truncated)
    ["WEATHER_snow"] = "Neig", -- 4 (Truncated)
    ["WEATHER_snowlight"] = "Neige Lég", -- 9
    ["WEATHER_sunny"] = "Enso.", -- 5 (Truncated)
    ["WEATHER_thunder"] = "Tonnere", -- 7
    ["WEATHER_thunderstorm"] = "Orage       ", -- 12 (Padded)
    ["WEATHER_whiteout"] = "Voile Bl", -- 8
}

-------------------------------------------------------------------------------
-- ROMANIAN (RO)
-------------------------------------------------------------------------------
Locales["ro"] = {
    ["need_to_pee"] = "Trebuie să faci!", -- 16 (Exact)
    ["already_peeing"] = "Deja faci pipi!", -- 15 (Exact)
    ["cant_do_now"] = "Nu poți face acum!      ", -- 24 (Padded)
    ["no_need_pee"] = "Nu e nevoie să faci acum!        ", -- 33 (Padded)
    ["peeing"] = "Faci...  ", -- 9 (Padded)
    ["already_consuming"] = "Deja consumi!     ", -- 18 (Padded)
    ["finished"] = "Gata!    ", -- 9 (Padded)
    ["healed"] = "Stats restaurate!  ", -- 19
    ["click_consume"] = "Click-stg consumă    ", -- 21 (Padded)
    ["consumption_progress"] = "%d/%d",
    ["take_bath"] = "Fă o Baie  ", -- 11 (Padded)
    ["exit_bath"] = "Apasă G să ieși     ", -- 20 (Padded)
    ["feel_refreshed"] = "Te simți bine!     ", -- 19 (Padded)
    ["notify_hot"] = "Îți este prea cald!",
    ["notify_cold"] = "Îți este prea frig!",
    ["notify_hunger"] = "Îți este foame!",
    ["notify_thirst"] = "Îți este sete!",
    ["notify_stress"] = "Ești stresat!",
    ["notify_bath"] = "Ai nevoie de o baie!",
    ["notify_toilet"] = "Ai nevoie la toaletă!",

    -- WASHING SYSTEM
    ["wash_hands"] = "Spală",
    ["water_source"] = "Sursă de apă",
    ["wash_complete"] = "Te-ai spălat!",
    ["wash_cooldown"] = "Tocmai ți-ai spălat mâinile și fața!",

    -- POISON SYSTEM
    ["poison_bitten"] = "Ai fost otrăvit!",
    ["poison_cleared"] = "Otrava a dispărut.",
    ["poison_cured"] = "Otrava a fost vindecată!",

    ["month_1"] = "Ianuarie", ["month_2"] = "Februarie", ["month_3"] = "Martie", ["month_4"] = "Aprilie",
    ["month_5"] = "Mai", ["month_6"] = "Iunie", ["month_7"] = "Iulie", ["month_8"] = "August",
    ["month_9"] = "Septembrie", ["month_10"] = "Octombrie", ["month_11"] = "Noiembrie", ["month_12"] = "Decembrie",

    ["enter_layout_code"] = "Introdu cod aspect        ", -- 26 (Padded)
    ["layout_not_compatible"] = "Cod aspect incompatibil cu HUD             ", -- 43 (Padded)
    ["settings_imported"] = "Setări importate cu succes!    ", -- 31 (Padded)
    ["invalid_code"] = "Cod invalid. Verifică format.         ", -- 38 (Padded)
    ["layout_copied"] = "Cod aspect copiat!              ", -- 32 (Padded)
    ["copy_failed"] = "Copiere eșuată. Vezi consola.             ", -- 42 (Padded)
    ["settings_saved"] = "Setări salvate!             ", -- 28 (Padded)

    ["hud_settings"] = "SETĂRI HUD  ", -- 12 (Padded)
    ["cat_general"] = "General", ["cat_voice"] = "Voce", ["cat_weapon"] = "Armă", ["cat_time"] = "Timp",
    ["cat_date"] = "Dată", ["cat_weather"] = "Vreme", ["cat_playerid"] = "ID Jucător", ["cat_money"] = "Bani",
    ["cat_health"] = "Sănătate", ["cat_stamina"] = "Stamină", ["cat_water"] = "Apă", ["cat_hunger"] = "Foame",
    ["cat_stress"] = "Stres", ["cat_bath"] = "Baie", ["cat_toilet"] = "Toaletă", ["cat_temp"] = "Temperatură",
    ["div_display"] = "Ecran  ", -- 7 (Padded)
    ["div_player_meta"] = "Metab. Jucător   ", -- 17 (Padded)
    ["div_horse_meta"] = "Metab. Cal      ", -- 16 (Padded)
    ["layout_standart"] = "Standard", -- 8
    ["layout_normal"] = "Normal", -- 6
    ["layout_story"] = "Poves", -- 5 (Truncated)
    ["btn_edit"] = "Edit Poziție ", -- 13 (Padded)
    ["btn_apply"] = "Aplică Setări ", -- 14 (Padded)
    ["btn_copy"] = "Copiază Set. ", -- 13 (Padded)
    ["btn_reset"] = "Reset", -- 5
    ["btn_save"] = "Salv", -- 4
    ["grid_size"] = "Măr. Grid", -- 9
    ["cinematic_mode"] = "Mod Cinematic ", -- 14 (Padded)
    ["hud_visibility"] = "Vizibil. Hud  ", -- 14 (Padded)

    ["vis_voice"] = "Vizibilit. Voce ", -- 16 (Padded)
    ["vis_weapon"] = "Vizibilit. Armă  ", -- 17 (Padded)
    ["vis_time"] = "Vizibilit. Timp", -- 15
    ["vis_date"] = "Vizibilit. Dată", -- 15
    ["vis_weather"] = "Vizibilit. Vreme  ", -- 18 (Padded)
    ["vis_playerid"] = "Vizibilit. ID       ", -- 20 (Padded)
    ["vis_money"] = "Vizibilit. Bani ", -- 16 (Padded)
    ["vis_health"] = "Vizibil. Viață   ", -- 17 (Padded)
    ["vis_stamina"] = "Vizibil. Stam.    ", -- 18 (Padded)
    ["vis_water"] = "Vizibilit. Apă  ", -- 16 (Padded)
    ["vis_hunger"] = "Vizibil. Foame   ", -- 17 (Padded)
    ["vis_stress"] = "Vizibil. Stres   ", -- 17 (Padded)
    ["vis_bath"] = "Vizibil. Baie  ", -- 15 (Padded)
    ["vis_toilet"] = "Vizibil. Toal.   ", -- 17 (Padded)
    ["vis_temp"] = "Temperatură", -- 11
    ["vis_horse"] = "HUD Cal  ", -- 9 (Padded)
    ["vis_horse_health"] = "Viață Cal   ", -- 12 (Padded)
    ["vis_horse_stamina"] = "Stamină Cal  ", -- 13 (Padded)

    ["size_voice"] = "Măr. Voce ", -- 10 (Padded)
    ["size_weapon"] = "Măr. Armă  ", -- 11 (Padded)
    ["size_time"] = "Măr. Timp", -- 9
    ["size_date"] = "Măr. Dată", -- 9
    ["size_weather"] = "Măr. Vreme  ", -- 12 (Padded)
    ["size_playerid"] = "Mărime ID     ", -- 14 (Padded)
    ["size_money"] = "Măr. Bani ", -- 10 (Padded)
    ["size_health"] = "Măr. Viață ", -- 11 (Padded)
    ["size_stamina"] = "Măr. Stam.  ", -- 12 (Padded)
    ["size_water"] = "Mărime Apă", -- 10
    ["size_hunger"] = "Măr. Foame ", -- 11 (Padded)
    ["size_stress"] = "Măr. Stres ", -- 11 (Padded)
    ["size_bath"] = "Măr. Baie", -- 9
    ["size_toilet"] = "Măr. Toal. ", -- 11 (Padded)
    ["size_temp"] = "Mărime Temp.    ", -- 16 (Padded)
    ["size_h_hud"] = "Mărime HUD Cal ", -- 14 (Padded)
    ["size_horse_health"] = "Mărime Viață Cal ", -- 17 (Padded)
    ["size_horse_stamina"] = "Mărime Stam Cal   ", -- 18 (Padded)

    ["color_time"] = "Cul. Timp ", -- 10 (Padded)
    ["color_date"] = "Cul. Dată ", -- 10 (Padded)
    ["color_weather"] = "Culoare Vreme", -- 13
    ["color_playerid"] = "Culoare ID     ", -- 15 (Padded)
    ["color_money"] = "Cul. Bani  ", -- 11 (Padded)
    ["color_health"] = "Cul. Viață  ", -- 12 (Padded)
    ["color_stamina"] = "Cul. Stam.   ", -- 13 (Padded)
    ["color_water"] = "Culoare Apă", -- 11
    ["color_hunger"] = "Cul. Foame  ", -- 12 (Padded)
    ["color_stress"] = "Cul. Stres  ", -- 12 (Padded)
    ["color_bath"] = "Cul. Baie ", -- 10 (Padded)
    ["color_toilet"] = "Cul. Toal.  ", -- 12 (Padded)
    ["color_horse_health"] = "Cul. Viață Cal    ", -- 18 (Padded)
    ["color_horse_stamina"] = "Cul. Stam Cal      ", -- 19 (Padded)

    ["toggle_on"] = "ON",
    ["toggle_off"] = "OFF",
    ["desc_hud_settings"] = "Personalizează setările.              ", -- 38 (Padded)
    ["desc_general_layouts"] = "Aspecte gata de utilizat.         ", -- 34 (Padded)
    ["desc_edit_mode"] = "Ajustează liber HUD-ul.       ", -- 30 (Padded)
    ["desc_apply_settings"] = "Importă de la jucători.            ", -- 35 (Padded)
    ["desc_grid_size"] = "Setează precizia grilei.      ", -- 30 (Padded)
    ["btn_edit_pos"] = "Edit Poziție",
    ["label_time"] = "Timp:",
    ["label_date"] = "Dată:",
    ["label_weather"] = "Vreme:",
    ["label_playerid"] = "ID:",
    ["label_money"] = "Sold:",
    ["unit_celsius"] = "'C",
    ["desc_size_voice"] = "Redim. indicator voce.     ", -- 27 (Padded)
    ["desc_size_weapon"] = "Redim. afișaj armă.       ", -- 26 (Padded)
    ["desc_size_time"] = "Redim. ceasul.             ", -- 27 (Padded)
    ["desc_size_date"] = "Redim. data.               ", -- 27 (Padded)
    ["desc_size_weather"] = "Redim. info vreme.         ", -- 27 (Padded)
    ["desc_size_playerid"] = "Redim. text ID jucător.     ", -- 28 (Padded)
    ["desc_size_money"] = "Redim. afișaj sold.         ", -- 28 (Padded)
    ["desc_size_health"] = "Redim. bară viață.       ", -- 25 (Padded)
    ["desc_size_stamina"] = "Redim. bară stam.        ", -- 25 (Padded)
    ["desc_size_water"] = "Redim. indicator sete.       ", -- 29 (Padded)
    ["desc_size_hunger"] = "Redim. bară foame.       ", -- 25 (Padded)
    ["desc_size_stress"] = "Redim. bară stres.       ", -- 25 (Padded)
    ["desc_size_bath"] = "Redim. metru igienă.        ", -- 28 (Padded)
    ["desc_size_toilet"] = "Redim. bară vezică.        ", -- 27 (Padded)
    ["desc_size_temp"] = "Redim. afișaj temp.        ", -- 27 (Padded)
    ["desc_size_h_hud"] = "Redim. panou cal.          ", -- 27 (Padded)
    ["desc_size_h_health"] = "Redim. viață cal.       ", -- 24 (Padded)
    ["desc_size_h_stamina"] = "Redim. stam cal.           ", -- 27 (Padded)
    ["title_general_layouts"] = "Aspecte Gen.   ", -- 15 (Padded)
    ["title_edit_mode"] = "Mod Editare ",

    -- WEATHER
    ["WEATHER_blizzard"] = "Viscol  ", -- 8 (Padded)
    ["WEATHER_clouds"] = "Nori  ", -- 6 (Padded)
    ["WEATHER_drizzle"] = "Burniță", -- 7
    ["WEATHER_fog"] = "Ceț", -- 3 (Truncated)
    ["WEATHER_groundblizzard"] = "Viscol la sol ", -- 14 (Padded)
    ["WEATHER_hail"] = "Grin", -- 4 (Truncated)
    ["WEATHER_highpressure"] = "Presiune Mar", -- 12 (Truncated)
    ["WEATHER_hurricane"] = "Uragan   ", -- 9 (Padded)
    ["WEATHER_misty"] = "Ceaț.", -- 5 (Truncated)
    ["WEATHER_overcast"] = "Înorat  ", -- 8 (Padded)
    ["WEATHER_overcastdark"] = "Înorat Întun", -- 12 (Truncated)
    ["WEATHER_rain"] = "Ploa", -- 4 (Truncated)
    ["WEATHER_sandstorm"] = "FurtNisip", -- 9
    ["WEATHER_shower"] = "Aversă", -- 6
    ["WEATHER_sleet"] = "Lapov", -- 5 (Truncated)
    ["WEATHER_snow"] = "Zăpa", -- 4 (Truncated)
    ["WEATHER_snowlight"] = "ZăpadaUșo", -- 9 (Truncated)
    ["WEATHER_sunny"] = "Însor", -- 5 (Truncated)
    ["WEATHER_thunder"] = "Tunete ", -- 7 (Padded)
    ["WEATHER_thunderstorm"] = "Furtună     ", -- 12 (Padded)
    ["WEATHER_whiteout"] = "Albire  ", -- 8 (Padded)
}

-------------------------------------------------------------------------------
-- TURKISH (TR)
-------------------------------------------------------------------------------
Locales["tr"] = {
    ["need_to_pee"] = "İşemen gerek!   ", -- 16 (Padded)
    ["already_peeing"] = "Zaten işiyorsun", -- 15 (Truncated to fit 15 chars)
    ["cant_do_now"] = "Şu an bunu yapamazsın!  ", -- 24 (Padded)
    ["no_need_pee"] = "Şu an işemene gerek yok!         ", -- 33 (Padded)
    ["peeing"] = "İşiyor...", -- 9
    ["already_consuming"] = "Zaten tüketiliyor!", -- 18
    ["finished"] = "Bitti!   ", -- 9 (Padded)
    ["healed"] = "Tüm statlar yenilendi!", -- 22
    ["click_consume"] = "Tüketmek için tıkla  ", -- 21 (Padded)
    ["consumption_progress"] = "%d/%d",
    ["take_bath"] = "Banyo Yap  ", -- 11 (Padded)
    ["exit_bath"] = "Çıkmak için G bas   ", -- 20 (Padded)
    ["feel_refreshed"] = "Yenilenmiş hisset! ", -- 19 (Padded)
    ["notify_hot"] = "Sıcak hissediyorsun!",
    ["notify_cold"] = "Soğuk hissediyorsun!",
    ["notify_hunger"] = "Aç hissediyorsun!",
    ["notify_thirst"] = "Susadım!",
    ["notify_stress"] = "Stresli hissediyorsun!",
    ["notify_bath"] = "Banyo yapman gerek!",
    ["notify_toilet"] = "Tuvalete gitmen gerek!",

    -- VOMIT SYSTEM
    ["vomiting"] = "Kusuyorsun...",
    ["vomit_done"] = "Kendini daha iyi hissediyorsun.",

    -- DRUNK SYSTEM
    ["drunk_ended"] = "Ayıldın.",

    -- WASHING SYSTEM
    ["wash_hands"] = "Yıka",
    ["water_source"] = "Su Kaynağı",
    ["wash_complete"] = "Elini yüzünü yıkadın!",
    ["wash_cooldown"] = "Az önce elini yüzünü yıkadın!",

    -- POISON SYSTEM
    ["poison_bitten"] = "Zehirlendin!",
    ["poison_cleared"] = "Zehir etkisini yitirdi.",
    ["poison_cured"] = "Zehir tedavi edildi!",

    ["month_1"] = "Ocak", ["month_2"] = "Şubat", ["month_3"] = "Mart", ["month_4"] = "Nisan",
    ["month_5"] = "Mayıs", ["month_6"] = "Haziran", ["month_7"] = "Temmuz", ["month_8"] = "Ağustos",
    ["month_9"] = "Eylül", ["month_10"] = "Ekim", ["month_11"] = "Kasım", ["month_12"] = "Aralık",

    ["enter_layout_code"] = "Düzen kodu girin          ", -- 26 (Padded)
    ["layout_not_compatible"] = "Düzen kodu bu HUD ile uyumsuz              ", -- 43 (Padded)
    ["settings_imported"] = "Ayarlar başarıyla alındı!      ", -- 31 (Padded)
    ["invalid_code"] = "Geçersiz kod. Formatı dene.           ", -- 38 (Padded)
    ["layout_copied"] = "Düzen kodu kopyalandı!          ", -- 32 (Padded)
    ["copy_failed"] = "Kopyalama hatalı. Konsola bak.            ", -- 42 (Padded)
    ["settings_saved"] = "Ayarlar kaydedildi!         ", -- 28 (Padded)

    ["hud_settings"] = "HUD AYARLARI", -- 12
    ["cat_general"] = "Genel", ["cat_voice"] = "Ses", ["cat_weapon"] = "Silah", ["cat_time"] = "Zaman",
    ["cat_date"] = "Tarih", ["cat_weather"] = "Hava", ["cat_playerid"] = "Oyuncu ID", ["cat_money"] = "Para",
    ["cat_health"] = "Can", ["cat_stamina"] = "Kondisyon", ["cat_water"] = "Su", ["cat_hunger"] = "Açlık",
    ["cat_stress"] = "Stres", ["cat_bath"] = "Banyo", ["cat_toilet"] = "Tuvalet", ["cat_temp"] = "Sıcaklık",
    ["div_display"] = "Ekran  ", -- 7 (Padded)
    ["div_player_meta"] = "Oyuncu Metabol.  ", -- 17 (Padded)
    ["div_horse_meta"] = "At Metabolizma  ", -- 16 (Padded)
    ["layout_standart"] = "Standart", -- 8
    ["layout_normal"] = "Normal", -- 6
    ["layout_story"] = "Hikay", -- 5 (Truncated)
    ["btn_edit"] = "Düzenle      ", -- 13 (Padded)
    ["btn_apply"] = "Ayarı Uygula  ", -- 14 (Padded)
    ["btn_copy"] = "Ayarı Kopyala", -- 13
    ["btn_reset"] = "Sıfırla", -- 5 (Padded)
    ["btn_save"] = "Kaydet", -- 4
    ["grid_size"] = "Izgara B.", -- 9
    ["cinematic_mode"] = "Sinema Modu   ", -- 14 (Padded)
    ["hud_visibility"] = "Hud Görünüm   ", -- 14 (Padded)

    ["vis_voice"] = "Ses Görünümü    ", -- 16 (Padded)
    ["vis_weapon"] = "Silah Görünümü   ", -- 17 (Padded)
    ["vis_weapon_right"] = "Sağ El Silahı    ", -- 17 (Padded)
    ["vis_weapon_left"] = "Sol El Silahı   ", -- 16 (Padded)
    ["vis_time"] = "Saat Görünümü  ", -- 15 (Padded)
    ["vis_date"] = "Tarih Görünümü ", -- 15 (Padded)
    ["vis_weather"] = "Hava Görünümü     ", -- 18 (Padded)
    ["vis_playerid"] = "ID Görünürlüğü      ", -- 20 (Padded)
    ["vis_money"] = "Para Görünümü   ", -- 16 (Padded)
    ["vis_health"] = "Can Görünümü     ", -- 17 (Padded)
    ["vis_stamina"] = "Kond. Görünüm     ", -- 18 (Padded)
    ["vis_water"] = "Su Görünümü     ", -- 16 (Padded)
    ["vis_hunger"] = "Açlık Görünüm    ", -- 17 (Padded)
    ["vis_stress"] = "Stres Görünüm    ", -- 17 (Padded)
    ["vis_bath"] = "Banyo Görünüm  ", -- 15 (Padded)
    ["vis_toilet"] = "Wc Görünümü      ", -- 17 (Padded)
    ["vis_temp"] = "Sıcaklık   ", -- 11 (Padded)
    ["vis_horse"] = "At HUD   ", -- 9 (Padded)
    ["vis_horse_health"] = "At Sağlığı  ", -- 12 (Padded)
    ["vis_horse_stamina"] = "At Kondisyon ", -- 13 (Padded)

    ["size_voice"] = "Ses Boyutu", -- 10
    ["size_weapon"] = "Silah Boyut", -- 11
    ["size_weapon_right"] = "Sağ El Boyutu  ", -- 15 (Padded)
    ["size_weapon_left"] = "Sol El Boyutu ", -- 14 (Padded)
    ["size_time"] = "Saat Boy.", -- 9 (Truncated)
    ["size_date"] = "Tarih B. ", -- 9 (Padded)
    ["size_weather"] = "Hava Boyutu ", -- 12 (Padded)
    ["size_playerid"] = "Oyuncu ID B.  ", -- 14 (Padded)
    ["size_money"] = "Para Boyut", -- 10
    ["size_health"] = "Can Boyutu ", -- 11 (Padded)
    ["size_stamina"] = "Kond. Boyut ", -- 12 (Padded)
    ["size_water"] = "Su Boyutu ", -- 10 (Padded)
    ["size_hunger"] = "Açlık Boyut", -- 11
    ["size_stress"] = "Stres Boyut", -- 11
    ["size_bath"] = "Banyo B. ", -- 9 (Padded)
    ["size_toilet"] = "Wc Boyutu  ", -- 11 (Padded)
    ["size_temp"] = "Sıcaklık Boyut  ", -- 16 (Padded)
    ["size_h_hud"] = "At HUD Boyutu  ", -- 14 (Padded)
    ["size_horse_health"] = "At Canı Boyutu   ", -- 17 (Padded)
    ["size_horse_stamina"] = "At Kondisyon Boyut", -- 18

    ["color_voice"] = "Ses Rengi  ", -- 11 (Padded)
    ["color_time"] = "Saat Rengi", -- 10
    ["color_date"] = "Tarih Reng", -- 10
    ["color_weather"] = "Hava Rengi   ", -- 13 (Padded)
    ["color_playerid"] = "ID Rengi       ", -- 15 (Padded)
    ["color_money"] = "Para Rengi ", -- 11 (Padded)
    ["color_health"] = "Can Rengi   ", -- 12 (Padded)
    ["color_stamina"] = "Kond. Renk   ", -- 13 (Padded)
    ["color_water"] = "Su Rengi   ", -- 11 (Padded)
    ["color_hunger"] = "Açlık Renk  ", -- 12 (Padded)
    ["color_stress"] = "Stres Renk  ", -- 12 (Padded)
    ["color_bath"] = "Banyo Renk", -- 10
    ["color_toilet"] = "Wc Rengi    ", -- 12 (Padded)
    ["color_horse_health"] = "At Canı Rengi     ", -- 18 (Padded)
    ["color_horse_stamina"] = "At Kondisyon Renk  ", -- 19 (Padded)
    ["color_temp"] = "Sıcaklık Rengi   ", -- 17 (Padded)
    ["color_h_hud"] = "At HUD Rengi   ", -- 15 (Padded)

    ["voice_follow_head"] = "Kafa Takip", -- 11
    ["voice_follow_head_desc"] = "Sesi oyuncunun kafası yanına yerleştir", -- 39 (Padded)
    ["voice_talk_only"] = "Konuşurken", -- 10
    ["voice_talk_only_desc"] = "Sadece konuşurken göster", -- 24

    ["toggle_on"] = "AÇ",
    ["toggle_off"] = "KPT ", -- 3 (Padded)
    ["desc_hud_settings"] = "Ayarları kendine göre yap.            ", -- 38 (Padded)
    ["desc_general_layouts"] = "Kullanıma hazır tasarımlar.       ", -- 34 (Padded)
    ["desc_edit_mode"] = "HUD'u serbestçe düzenle.      ", -- 30 (Padded)
    ["desc_apply_settings"] = "Başkasından ayar yükle.            ", -- 35 (Padded)
    ["desc_grid_size"] = "Izgara hassasiyeti.           ", -- 30 (Padded)
    ["btn_edit_pos"] = "Konum Düzenle",
    ["label_time"] = "Saat:",
    ["label_date"] = "Tarih:",
    ["label_weather"] = "Hava:",
    ["label_playerid"] = "ID:",
    ["label_money"] = "Para:",
    ["unit_celsius"] = "'C",
    ["desc_size_voice"] = "Ses göstergesini boyutla.  ", -- 27 (Padded)
    ["desc_size_weapon"] = "Silah ekranını boyutla.   ", -- 26 (Padded)
    ["desc_size_weapon_right"] = "Sağ el silah boyutunu ayarla.    ",
    ["desc_size_weapon_left"] = "Sol el silah boyutunu ayarla.    ",
    ["desc_size_time"] = "Saati boyutlandır.         ", -- 27 (Padded)
    ["desc_size_date"] = "Tarihi boyutlandır.        ", -- 27 (Padded)
    ["desc_size_weather"] = "Hava bilgisini boyutla.    ", -- 27 (Padded)
    ["desc_size_playerid"] = "ID yazısını boyutla.        ", -- 28 (Padded)
    ["desc_size_money"] = "Bakiyeyi boyutlandır.       ", -- 28 (Padded)
    ["desc_size_health"] = "Can barını boyutla.      ", -- 25 (Padded)
    ["desc_size_stamina"] = "Kondisyonu boyutla.      ", -- 25 (Padded)
    ["desc_size_water"] = "Su göstergesini boyutla.     ", -- 29 (Padded)
    ["desc_size_hunger"] = "Açlık barını boyutla.    ", -- 25 (Padded)
    ["desc_size_stress"] = "Stres barını boyutla.    ", -- 25 (Padded)
    ["desc_size_bath"] = "Hijyeni boyutlandır.        ", -- 28 (Padded)
    ["desc_size_toilet"] = "Wc barını boyutlandır.     ", -- 27 (Padded)
    ["desc_size_temp"] = "Sıcaklığı boyutlandır.     ", -- 27 (Padded)
    ["desc_size_h_hud"] = "At panelini boyutla.       ", -- 27 (Padded)
    ["desc_size_h_health"] = "At can barı boyutu.     ", -- 24 (Padded)
    ["desc_size_h_stamina"] = "At kondisyon boyutu.       ", -- 27 (Padded)
    ["title_general_layouts"] = "Genel Düzenler ", -- 15 (Padded)
    ["title_edit_mode"] = "Düzenleme   ", -- 12 (Padded)

    -- WEATHER
    ["WEATHER_blizzard"] = "Tipi    ", -- 8 (Padded)
    ["WEATHER_clouds"] = "Bulut ", -- 6 (Padded)
    ["WEATHER_drizzle"] = "Çiselti", -- 7
    ["WEATHER_fog"] = "Sis", -- 3
    ["WEATHER_groundblizzard"] = "Yer Tipisi    ", -- 14 (Padded)
    ["WEATHER_hail"] = "Dolu", -- 4
    ["WEATHER_highpressure"] = "Yüksek Sıcak. ", -- 12 (Padded)
    ["WEATHER_hurricane"] = "Kasırga  ", -- 9 (Padded)
    ["WEATHER_misty"] = "Puslu", -- 5
    ["WEATHER_overcast"] = "Kapalı  ", -- 8 (Padded)
    ["WEATHER_overcastdark"] = "Koyu Kapalı ", -- 12 (Padded)
    ["WEATHER_rain"] = "Yağmurlu.", -- 4 (Truncated)
    ["WEATHER_sandstorm"] = "Kum Fırtınalı", -- 9
    ["WEATHER_shower"] = "Sağnak", -- 6
    ["WEATHER_sleet"] = "Sulu", -- 5 (Truncated)
    ["WEATHER_snow"] = "Karlı ", -- 4 (Padded)
    ["WEATHER_snowlight"] = "Hafif Kar", -- 9
    ["WEATHER_sunny"] = "Güneşli", -- 5 (Truncated)
    ["WEATHER_thunder"] = "Gök Gürültülü", -- 7
    ["WEATHER_thunderstorm"] = "Fırtınalı", -- 12 (Padded)
    ["WEATHER_whiteout"] = "Ak Görüş", -- 8
}

-------------------------------------------------------------------------------
-- GERMAN (DE)
-------------------------------------------------------------------------------
Locales["de"] = {
    ["need_to_pee"] = "Musst pinkeln!  ", -- 16 (Padded)
    ["already_peeing"] = "Pinkelst schon!", -- 15 (Exact)
    ["cant_do_now"] = "Geht gerade nicht!      ", -- 24 (Padded)
    ["no_need_pee"] = "Musst gerade nicht!              ", -- 33 (Padded)
    ["peeing"] = "Pinkeln. ", -- 9 (Padded)
    ["already_consuming"] = "Konsumierst schon!", -- 18 (Exact)
    ["finished"] = "Fertig!  ", -- 9 (Padded)
    ["healed"] = "Stats wiederhergest!", -- 19
    ["click_consume"] = "Linksklick Konsum    ", -- 21 (Padded)
    ["consumption_progress"] = "%d/%d",
    ["take_bath"] = "Bad nehmen ", -- 11 (Padded)
    ["exit_bath"] = "Drücke G zum Raus   ", -- 20 (Padded)
    ["feel_refreshed"] = "Fühlst dich frisch!", -- 19 (Exact)
    ["notify_hot"] = "Dir ist zu heiß!",
    ["notify_cold"] = "Dir ist zu kalt!",
    ["notify_hunger"] = "Du hast Hunger!",
    ["notify_thirst"] = "Du hast Durst!",
    ["notify_stress"] = "Du bist gestresst!",
    ["notify_bath"] = "Du brauchst ein Bad!",
    ["notify_toilet"] = "Du musst auf die Toilette!",

    -- WASHING SYSTEM
    ["wash_hands"] = "Waschen",
    ["water_source"] = "Wasserquelle",
    ["wash_complete"] = "Du hast dich gewaschen!",
    ["wash_cooldown"] = "Du hast dir gerade Hände und Gesicht gewaschen!",

    -- POISON SYSTEM
    ["poison_bitten"] = "Du wurdest vergiftet!",
    ["poison_cleared"] = "Das Gift hat nachgelassen.",
    ["poison_cured"] = "Das Gift wurde geheilt!",

    ["month_1"] = "Januar", ["month_2"] = "Februar", ["month_3"] = "März", ["month_4"] = "April",
    ["month_5"] = "Mai", ["month_6"] = "Juni", ["month_7"] = "Juli", ["month_8"] = "August",
    ["month_9"] = "September", ["month_10"] = "Oktober", ["month_11"] = "November", ["month_12"] = "Dezember",

    ["enter_layout_code"] = "Layout-Code eingeben      ", -- 26 (Padded)
    ["layout_not_compatible"] = "Code inkompatibel mit HUD                  ", -- 43 (Padded)
    ["settings_imported"] = "Einst. importiert!             ", -- 31 (Padded)
    ["invalid_code"] = "Code ungültig. Format prüfen.         ", -- 38 (Padded)
    ["layout_copied"] = "Code in Zwischenablage!         ", -- 32 (Padded)
    ["copy_failed"] = "Kopie fehlgeschl. Siehe F8.               ", -- 42 (Padded)
    ["settings_saved"] = "Einstell. gespeichert!      ", -- 28 (Padded)

    ["hud_settings"] = "HUD EINSTELL", -- 12
    ["cat_general"] = "Allgemein", ["cat_voice"] = "Stimme", ["cat_weapon"] = "Waffe", ["cat_time"] = "Zeit",
    ["cat_date"] = "Datum", ["cat_weather"] = "Wetter", ["cat_playerid"] = "Spieler-ID", ["cat_money"] = "Geld",
    ["cat_health"] = "Gesundheit", ["cat_stamina"] = "Ausdauer", ["cat_water"] = "Wasser", ["cat_hunger"] = "Hunger",
    ["cat_stress"] = "Stress", ["cat_bath"] = "Bad", ["cat_toilet"] = "Toilette", ["cat_temp"] = "Temperatur",
    ["div_display"] = "Anzeige", -- 7
    ["div_player_meta"] = "Spieler Metab.   ", -- 17 (Padded)
    ["div_horse_meta"] = "Pferd Metab.    ", -- 16 (Padded)
    ["layout_standart"] = "Standart", -- 8
    ["layout_normal"] = "Normal", -- 6
    ["layout_story"] = "Story", -- 5
    ["btn_edit"] = "Position änd.", -- 13
    ["btn_apply"] = "Anwenden      ", -- 14 (Padded)
    ["btn_copy"] = "Kopieren     ", -- 13 (Padded)
    ["btn_reset"] = "Reset", -- 5
    ["btn_save"] = "Spr.", -- 4
    ["grid_size"] = "Rastergr.", -- 9
    ["cinematic_mode"] = "Kinomodus     ", -- 14 (Padded)
    ["hud_visibility"] = "HUD Sichtb.   ", -- 14 (Padded)

    ["vis_voice"] = "Stimme Sichtb.  ", -- 16 (Padded)
    ["vis_weapon"] = "Waffe Sichtb.    ", -- 17 (Padded)
    ["vis_time"] = "Zeit Sichtb.   ", -- 15 (Padded)
    ["vis_date"] = "Datum Sichtb.  ", -- 15 (Padded)
    ["vis_weather"] = "Wetter Sichtb.    ", -- 18 (Padded)
    ["vis_playerid"] = "ID Sichtbarke.      ", -- 20 (Padded)
    ["vis_money"] = "Geld Sichtb.    ", -- 16 (Padded)
    ["vis_health"] = "Leben Sichtb.    ", -- 17 (Padded)
    ["vis_stamina"] = "Ausd. Sichtb.     ", -- 18 (Padded)
    ["vis_water"] = "Wasser Sichtb.  ", -- 16 (Padded)
    ["vis_hunger"] = "Hunger Sichtb.   ", -- 17 (Padded)
    ["vis_stress"] = "Stress Sichtb.   ", -- 17 (Padded)
    ["vis_bath"] = "Bad Sichtbar.  ", -- 15 (Padded)
    ["vis_toilet"] = "WC Sichtbark.    ", -- 17 (Padded)
    ["vis_temp"] = "Temperatur ", -- 11 (Padded)
    ["vis_horse"] = "Pferd HUD", -- 9
    ["vis_horse_health"] = "Pferd Leben ", -- 12 (Padded)
    ["vis_horse_stamina"] = "Pferd Ausd.  ", -- 13 (Padded)

    ["size_voice"] = "Stimme Gr.", -- 10
    ["size_weapon"] = "Waffe Gr.  ", -- 11 (Padded)
    ["size_time"] = "Zeit Gr. ", -- 9 (Padded)
    ["size_date"] = "Datum Gr.", -- 9
    ["size_weather"] = "Wetter Gr.  ", -- 12 (Padded)
    ["size_playerid"] = "ID Größe      ", -- 14 (Padded)
    ["size_money"] = "Geld Gr.  ", -- 10 (Padded)
    ["size_health"] = "Leben Gr.  ", -- 11 (Padded)
    ["size_stamina"] = "Ausd. Gr.   ", -- 12 (Padded)
    ["size_water"] = "Wasser Gr.", -- 10
    ["size_hunger"] = "Hunger Gr. ", -- 11 (Padded)
    ["size_stress"] = "Stress Gr. ", -- 11 (Padded)
    ["size_bath"] = "Bad Größe", -- 9
    ["size_toilet"] = "WC Größe   ", -- 11 (Padded)
    ["size_temp"] = "Temp. Größe     ", -- 16 (Padded)
    ["size_h_hud"] = "Pferd HUD Gr.  ", -- 14 (Padded)
    ["size_horse_health"] = "Pferd Leben Gr.  ", -- 17 (Padded)
    ["size_horse_stamina"] = "Pferd Ausd. Gr.   ", -- 18 (Padded)

    ["color_time"] = "Zeit Farbe", -- 10
    ["color_date"] = "Datum Farb", -- 10
    ["color_weather"] = "Wetter Farb  ", -- 13 (Padded)
    ["color_playerid"] = "ID Farbe       ", -- 15 (Padded)
    ["color_money"] = "Geld Farbe ", -- 11 (Padded)
    ["color_health"] = "Leben Farb  ", -- 12 (Padded)
    ["color_stamina"] = "Ausd. Farb   ", -- 13 (Padded)
    ["color_water"] = "Wasser Farb", -- 11
    ["color_hunger"] = "Hunger Farb ", -- 12 (Padded)
    ["color_stress"] = "Stress Farb ", -- 12 (Padded)
    ["color_bath"] = "Bad Farbe ", -- 10 (Padded)
    ["color_toilet"] = "WC Farbe    ", -- 12 (Padded)
    ["color_horse_health"] = "Pferd Leben Farb  ", -- 18 (Padded)
    ["color_horse_stamina"] = "Pferd Ausd. Farb   ", -- 19 (Padded)

    ["toggle_on"] = "AN",
    ["toggle_off"] = "AUS",
    ["desc_hud_settings"] = "Passe Einstellungen an.               ", -- 38 (Padded)
    ["desc_general_layouts"] = "Vorgefertigte Layouts.            ", -- 34 (Padded)
    ["desc_edit_mode"] = "HUD frei anpassen.            ", -- 30 (Padded)
    ["desc_apply_settings"] = "Import von anderen.                ", -- 35 (Padded)
    ["desc_grid_size"] = "Raster-Genauigkeit.           ", -- 30 (Padded)
    ["btn_edit_pos"] = "Pos. ändern  ", -- 13 (Padded)
    ["label_time"] = "Zeit:",
    ["label_date"] = "Datum:",
    ["label_weather"] = "Wetter:",
    ["label_playerid"] = "ID:",
    ["label_money"] = "Saldo:",
    ["unit_celsius"] = "'C",
    ["desc_size_voice"] = "Größe der Stimme.          ", -- 27 (Padded)
    ["desc_size_weapon"] = "Größe der Waffe.          ", -- 26 (Padded)
    ["desc_size_time"] = "Größe der Uhr.             ", -- 27 (Padded)
    ["desc_size_date"] = "Größe des Datums.          ", -- 27 (Padded)
    ["desc_size_weather"] = "Größe Wetterinfo.          ", -- 27 (Padded)
    ["desc_size_playerid"] = "Größe Spieler-ID.           ", -- 28 (Padded)
    ["desc_size_money"] = "Größe Kontostand.           ", -- 28 (Padded)
    ["desc_size_health"] = "Größe Lebensbalken.      ", -- 25 (Padded)
    ["desc_size_stamina"] = "Größe Ausdauer.          ", -- 25 (Padded)
    ["desc_size_water"] = "Größe Wasserbalken.          ", -- 29 (Padded)
    ["desc_size_hunger"] = "Größe Hungerbalken.      ", -- 25 (Padded)
    ["desc_size_stress"] = "Größe Stressbalken.      ", -- 25 (Padded)
    ["desc_size_bath"] = "Größe Hygiene.              ", -- 28 (Padded)
    ["desc_size_toilet"] = "Größe Blasenbalken.        ", -- 27 (Padded)
    ["desc_size_temp"] = "Größe Temp-Anzeige.        ", -- 27 (Padded)
    ["desc_size_h_hud"] = "Größe Pferd-HUD.           ", -- 27 (Padded)
    ["desc_size_h_health"] = "Größe Pferd-Leben.      ", -- 24 (Padded)
    ["desc_size_h_stamina"] = "Größe Pferd-Ausd.          ", -- 27 (Padded)
    ["title_general_layouts"] = "Layouts        ", -- 15 (Padded)
    ["title_edit_mode"] = "Edit-Modus  ", -- 12 (Padded)

    -- WEATHER
    ["WEATHER_blizzard"] = "Blizzard", -- 8
    ["WEATHER_clouds"] = "Wolken", -- 6
    ["WEATHER_drizzle"] = "Nieseln", -- 7
    ["WEATHER_fog"] = "Neb", -- 3 (Truncated)
    ["WEATHER_groundblizzard"] = "Bodenblizzard ", -- 14 (Padded)
    ["WEATHER_hail"] = "Hage", -- 4 (Truncated)
    ["WEATHER_highpressure"] = "Hochdruck   ", -- 12 (Padded)
    ["WEATHER_hurricane"] = "Hurrikan ", -- 9 (Padded)
    ["WEATHER_misty"] = "Dunst", -- 5
    ["WEATHER_overcast"] = "Bedeckt ", -- 8 (Padded)
    ["WEATHER_overcastdark"] = "DunkelWolken", -- 12
    ["WEATHER_rain"] = "Rege", -- 4 (Truncated)
    ["WEATHER_sandstorm"] = "Sandsturm", -- 9
    ["WEATHER_shower"] = "Schuer", -- 6 (Truncated)
    ["WEATHER_sleet"] = "Schne", -- 5 (Truncated)
    ["WEATHER_snow"] = "Schn", -- 4 (Truncated)
    ["WEATHER_snowlight"] = "LeichSchN", -- 9 (Truncated)
    ["WEATHER_sunny"] = "Sonni", -- 5 (Truncated)
    ["WEATHER_thunder"] = "Donner ", -- 7 (Padded)
    ["WEATHER_thunderstorm"] = "Gewitter    ", -- 12 (Padded)
    ["WEATHER_whiteout"] = "Whiteout", -- 8
}

-------------------------------------------------------------------------------
-- AZERBAIJANI (AZ)
-------------------------------------------------------------------------------
Locales["az"] = {
     ["need_to_pee"] = "Tuvalete getmelisen!", -- 20 chars
    ["already_peeing"] = "Artiq tuvaletdesen", -- 18 chars
    ["cant_do_now"] = "Bunu indi ede bilmezsen!", -- 25 chars
    ["no_need_pee"] = "Hele tuvalete getmeye ehtiyac yoxdur!", -- 38 chars
    ["peeing"] = "Tuvaletde", -- 9 chars
    ["already_consuming"] = "Artiq yeyirsen!  ", -- 18 chars
    ["finished"] = "Hazirdir!", -- 9 chars
    ["healed"] = "Butun statlar berpa!", -- 20 chars
    ["click_consume"] = "Yemek ucun sol klik", -- 21 chars
    ["consumption_progress"] = "%d/%d",
    ["take_bath"] = "Dus Qebul Et", -- 12 chars
    ["exit_bath"] = "Cixmaq ucun G basin ", -- 20 chars
    ["feel_refreshed"] = "Ozunu tezelenmis his", -- 19 chars
    ["notify_hunger"] = "Acmaga basladiniz.",
    ["notify_thirst"] = "Susayirsiniz.",
    ["notify_stress"] = "Gergin hiss edirsiniz.",
    ["notify_toilet"] = "Tuvalete getmelisiniz.",
    ["notify_bath"] = "Pis qoxursunuz, Cimin.",
    ["notify_hot"] = "Cox istidir, zerer gorursunuz!",
    ["notify_cold"] = "Cox soyuqdur, donursunuz!",

    -- WASHING SYSTEM
    ["wash_hands"] = "Yu",
    ["water_source"] = "Su Menbesi",
    ["wash_complete"] = "Ellerini ve uzunu yudun!",
    ["wash_cooldown"] = "Indicə əllərini və üzünü yudun!",

    -- POISON SYSTEM
    ["poison_bitten"] = "Zəhərləndin!",
    ["poison_cleared"] = "Zəhər təsirini itirdi.",
    ["poison_cured"] = "Zəhər müalicə edildi!",

    ["month_1"] = "Yanvar", ["month_2"] = "Fevral", ["month_3"] = "Mart", ["month_4"] = "Aprel",
    ["month_5"] = "May", ["month_6"] = "İyun", ["month_7"] = "İyul", ["month_8"] = "Avqust",
    ["month_9"] = "Sentyabr", ["month_10"] = "Oktyabr", ["month_11"] = "Noyabr", ["month_12"] = "Dekabr",

    ["enter_layout_code"] = "Tertibat kodu daxil edin ", -- 27 chars
    ["layout_not_compatible"] = "Tertibat kodu bu HUD ile uygun deyil         ", -- 44 chars
    ["settings_imported"] = "Tenzimler ugurla idxal edildi!", -- 31 chars
    ["invalid_code"] = "Etibarsiz kod. Formati yoxlayin.      ", -- 39 chars
    ["layout_copied"] = "Tertibat kodu bufere kopyalandi!", -- 33 chars
    ["copy_failed"] = "Kopyalama xetasi. Kod konsolda (F8).  ", -- 43 chars
    ["settings_saved"] = "Tenzimler ugurla saxlanildi!", -- 28 chars

    ["hud_settings"] = "HUD TENZIMLER", -- 12 chars
    
    ["cat_general"] = " Umumi ", -- 7 chars
    ["cat_voice"] = "  Ses", -- 5 chars
    ["cat_weapon"] = "Silah ", -- 6 chars
    ["cat_time"] = "Vaxt", -- 4 chars
    ["cat_date"] = "Tari", -- 4 chars
    ["cat_weather"] = " Hava  ", -- 7 chars
    ["cat_playerid"] = "Oyuncu ID", -- 9 chars
    ["cat_money"] = "  Pul", -- 5 chars
    ["cat_health"] = "Saglam", -- 6 chars
    ["cat_stamina"] = "Enerji ", -- 7 chars
    ["cat_water"] = "   Su", -- 5 chars
    ["cat_hunger"] = " Acliq", -- 6 chars
    ["cat_stress"] = "Stress", -- 6 chars
    ["cat_bath"] = " Dus", -- 4 chars
    ["cat_toilet"] = "Kisesi", -- 6 chars
    ["cat_temp"] = "Temperatur ", -- 11 chars
    ["div_display"] = "Ekran  ", -- 7 (Padded)
    ["div_player_meta"] = "Oyunçu Metabol.  ", -- 17 (Padded)
    ["div_horse_meta"] = "At Metabolizmi  ", -- 16 (Padded)
    ["layout_standart"] = "Standart", -- 8
    ["layout_normal"] = "Normal", -- 6
    ["layout_story"] = "Süjet", -- 5
    ["btn_edit"] = "Düzəliş Et   ", -- 13 (Padded)
    ["btn_apply"] = "Tətbiq Et     ", -- 14 (Padded)
    ["btn_copy"] = "Kopyala      ", -- 13 (Padded)
    ["btn_reset"] = "Sıfır", -- 5 (Padded)
    ["btn_save"] = "Saxl", -- 4
    ["grid_size"] = "Tor Ölç. ", -- 9 (Padded)
    ["cinematic_mode"] = "Kinematik Mod ", -- 14 (Padded)
    ["hud_visibility"] = "Hud Görünüşü  ", -- 14 (Padded)

    ["vis_voice"] = "Səs Görünüşü    ", -- 16 (Padded)
    ["vis_weapon"] = "Silah Görünüşü   ", -- 17 (Padded)
    ["vis_time"] = "Saat Görünüşü  ", -- 15 (Padded)
    ["vis_date"] = "Tarix Görünüşü ", -- 15 (Padded)
    ["vis_weather"] = "Hava Görünüşü     ", -- 18 (Padded)
    ["vis_playerid"] = "ID Görünüşü         ", -- 20 (Padded)
    ["vis_money"] = "Pul Görünüşü    ", -- 16 (Padded)
    ["vis_health"] = "Can Görünüşü     ", -- 17 (Padded)
    ["vis_stamina"] = "Stamina Görün.    ", -- 18 (Padded)
    ["vis_water"] = "Su Görünüşü     ", -- 16 (Padded)
    ["vis_hunger"] = "Aclıq Görünüşü   ", -- 17 (Padded)
    ["vis_stress"] = "Stres Görünüşü   ", -- 17 (Padded)
    ["vis_bath"] = "Hamam Görün.   ", -- 15 (Padded)
    ["vis_toilet"] = "Tualet Görün.    ", -- 17 (Padded)
    ["vis_temp"] = "Temperatur ", -- 11 (Padded)
    ["vis_horse"] = "At HUD-u ", -- 9 (Padded)
    ["vis_horse_health"] = "At Canı     ", -- 12 (Padded)
    ["vis_horse_stamina"] = "At Staminası ", -- 13 (Padded)

    ["size_voice"] = "Səs Ölç.  ", -- 10 (Padded)
    ["size_weapon"] = "Silah Ölç. ", -- 11 (Padded)
    ["size_time"] = "Saat Ölç.", -- 9
    ["size_date"] = "Tarix Öl.", -- 9
    ["size_weather"] = "Hava Ölç.   ", -- 12 (Padded)
    ["size_playerid"] = "ID Ölçüsü     ", -- 14 (Padded)
    ["size_money"] = "Pul Ölç.  ", -- 10 (Padded)
    ["size_health"] = "Can Ölç.   ", -- 11 (Padded)
    ["size_stamina"] = "Stamina Öl. ", -- 12 (Padded)
    ["size_water"] = "Su Ölç.   ", -- 10 (Padded)
    ["size_hunger"] = "Aclıq Ölç. ", -- 11 (Padded)
    ["size_stress"] = "Stres Ölç. ", -- 11 (Padded)
    ["size_bath"] = "Hamam Öl.", -- 9
    ["size_toilet"] = "Tualet Öl. ", -- 11 (Padded)
    ["size_temp"] = "Temp. Ölçüsü    ", -- 16 (Padded)
    ["size_h_hud"] = "At HUD Ölçüsü  ", -- 14 (Padded)
    ["size_horse_health"] = "At Canı Ölç.     ", -- 17 (Padded)
    ["size_horse_stamina"] = "At Stamina Ölç.   ", -- 18 (Padded)

    ["color_time"] = "Saat Rəngi", -- 10
    ["color_date"] = "Tarix Rəng", -- 10
    ["color_weather"] = "Hava Rəngi   ", -- 13 (Padded)
    ["color_playerid"] = "ID Rəngi       ", -- 15 (Padded)
    ["color_money"] = "Pul Rəngi  ", -- 11 (Padded)
    ["color_health"] = "Can Rəngi   ", -- 12 (Padded)
    ["color_stamina"] = "Stamina Rəng ", -- 13 (Padded)
    ["color_water"] = "Su Rəngi   ", -- 11 (Padded)
    ["color_hunger"] = "Aclıq Rəng  ", -- 12 (Padded)
    ["color_stress"] = "Stres Rəng  ", -- 12 (Padded)
    ["color_bath"] = "Hamam Rəng", -- 10
    ["color_toilet"] = "Tualet Rəng ", -- 12 (Padded)
    ["color_horse_health"] = "At Canı Rəngi     ", -- 18 (Padded)
    ["color_horse_stamina"] = "At Stamina Rəng    ", -- 19 (Padded)

    ["toggle_on"] = "BELI", -- 4 chars
    ["toggle_off"] = "XEYR", -- 4 chars
    ["desc_hud_settings"] = "Ayarları özünə görə dəyiş.            ", -- 38 (Padded)
    ["desc_general_layouts"] = "Hazır dizaynlar.                  ", -- 34 (Padded)
    ["desc_edit_mode"] = "HUD-u sərbəst tənzimlə.       ", -- 30 (Padded)
    ["desc_apply_settings"] = "Başqasından ayar yüklə.            ", -- 35 (Padded)
    ["desc_grid_size"] = "Tor dəqiqliyini seç.          ", -- 30 (Padded)
    ["btn_edit_pos"] = "Mövqe Düzəlt",
    ["label_time"] = "Saat:",
    ["label_date"] = "Tarix:",
    ["label_weather"] = "Hava:",
    ["label_playerid"] = "ID:",
    ["label_money"] = "Balans:",
    ["unit_celsius"] = "'C",
    ["desc_size_voice"] = "Səs göstəricisini ölç.     ", -- 27 (Padded)
    ["desc_size_weapon"] = "Silah ekranını ölç.       ", -- 26 (Padded)
    ["desc_size_time"] = "Saatı ölçüləndir.          ", -- 27 (Padded)
    ["desc_size_date"] = "Tarixi ölçüləndir.         ", -- 27 (Padded)
    ["desc_size_weather"] = "Havanı ölçüləndir.         ", -- 27 (Padded)
    ["desc_size_playerid"] = "ID yazısını ölç.            ", -- 28 (Padded)
    ["desc_size_money"] = "Balansı ölçüləndir.         ", -- 28 (Padded)
    ["desc_size_health"] = "Can barını ölç.          ", -- 25 (Padded)
    ["desc_size_stamina"] = "Stamina barını ölç.      ", -- 25 (Padded)
    ["desc_size_water"] = "Su göstəricisini ölç.        ", -- 29 (Padded)
    ["desc_size_hunger"] = "Aclıq barını ölç.        ", -- 25 (Padded)
    ["desc_size_stress"] = "Stres barını ölç.        ", -- 25 (Padded)
    ["desc_size_bath"] = "Təmizliyi ölç.              ", -- 28 (Padded)
    ["desc_size_toilet"] = "Tualet barını ölç.         ", -- 27 (Padded)
    ["desc_size_temp"] = "Temperaturu ölç.           ", -- 27 (Padded)
    ["desc_size_h_hud"] = "At panelini ölç.           ", -- 27 (Padded)
    ["desc_size_h_health"] = "At canı ölçüsü.         ", -- 24 (Padded)
    ["desc_size_h_stamina"] = "At staminası ölçüsü.       ", -- 27 (Padded)
    ["title_general_layouts"] = "Ümumi Düzənlər ", -- 15 (Padded)
    ["title_edit_mode"] = "Düzəliş Modu", -- 12

    -- WEATHER
    ["WEATHER_blizzard"] = "Çovğun",
    ["WEATHER_clouds"] = "Buludlu",
    ["WEATHER_drizzle"] = "Çiskin",
    ["WEATHER_fog"] = "Dumanlı",
    ["WEATHER_groundblizzard"] = "Yerdə çovğun",
    ["WEATHER_hail"] = "Dolu",
    ["WEATHER_highpressure"] = "Yüksək təzyiq",
    ["WEATHER_hurricane"] = "Qasırğa",
    ["WEATHER_misty"] = "Dumanlı",
    ["WEATHER_overcast"] = "Tutqun",
    ["WEATHER_overcastdark"] = "Qaranlıq tutqun",
    ["WEATHER_rain"] = "Yağışlı",
    ["WEATHER_sandstorm"] = "Qum fırtınası",
    ["WEATHER_shower"] = "Leysan",
    ["WEATHER_sleet"] = "Sulu qar",
    ["WEATHER_snow"] = "Qarlı",
    ["WEATHER_snowlight"] = "Yüngül qar",
    ["WEATHER_sunny"] = "Günəşli",
    ["WEATHER_thunder"] = "Göy gurultusu",
    ["WEATHER_thunderstorm"] = "Tufan",
    ["WEATHER_whiteout"] = "Göz-gözü görmür",
}

-------------------------------------------------------------------------------
-- BRAZILIAN PORTUGUESE (BR)
-------------------------------------------------------------------------------
Locales["br"] = {
    -- NOTIFICATIONS
    ["need_to_pee"] = "Você precisa urinar!", -- 20
    ["already_peeing"] = "Já está urinando!", -- 17
    ["cant_do_now"] = "Não pode fazer isso agora!", -- 26
    ["no_need_pee"] = "Você não precisa urinar agora!", -- 31
    ["peeing"] = "Urinando.", -- 9
    ["already_consuming"] = "Já está consumindo!", -- 19
    ["finished"] = "Pronto!  ", -- 9
    ["healed"] = "Stats restaurados!  ", -- 19
    ["click_consume"] = "Clique esq. consumir ", -- 21
    ["consumption_progress"] = "%d/%d",
    ["take_bath"] = "Tomar Banho", -- 11
    ["exit_bath"] = "Pressione G pra sair", -- 20
    ["feel_refreshed"] = "Você está renovado! ", -- 19
    ["notify_hot"] = "Você está com muito calor!",
    ["notify_cold"] = "Você está com muito frio!",
    ["notify_hunger"] = "Você está com fome!",
    ["notify_thirst"] = "Você está com sede!",
    ["notify_stress"] = "Você está estressado!",
    ["notify_bath"] = "Você precisa de banho!",
    ["notify_toilet"] = "Você precisa ir ao banheiro!",

    -- VOMIT SYSTEM
    ["vomiting"] = "Você está vomitando...",
    ["vomit_done"] = "Você se sente melhor.",

    -- DRUNK SYSTEM
    ["drunk_ended"] = "Você ficou sóbrio.",

    -- WASHING SYSTEM
    ["wash_hands"] = "Lavar",
    ["water_source"] = "Fonte de Água",
    ["wash_complete"] = "Você se lavou!",
    ["wash_cooldown"] = "Você acabou de lavar as mãos!",

    -- POISON SYSTEM
    ["poison_bitten"] = "Você foi envenenado!",
    ["poison_cleared"] = "O veneno passou.",
    ["poison_cured"] = "O veneno foi curado!",

    -- MONTHS
    ["month_1"] = "Janeiro", ["month_2"] = "Fevereiro", ["month_3"] = "Março", ["month_4"] = "Abril",
    ["month_5"] = "Maio", ["month_6"] = "Junho", ["month_7"] = "Julho", ["month_8"] = "Agosto",
    ["month_9"] = "Setembro", ["month_10"] = "Outubro", ["month_11"] = "Novembro", ["month_12"] = "Dezembro",

    -- HUD SETTINGS NOTIFICATIONS
    ["enter_layout_code"] = "Digite o código do layout", -- 26
    ["layout_not_compatible"] = "Código não é compatível com este HUD", -- 36
    ["settings_imported"] = "Configurações importadas!", -- 25
    ["invalid_code"] = "Código inválido. Verifique o formato.", -- 37
    ["layout_copied"] = "Código copiado para a área!", -- 27
    ["copy_failed"] = "Falha ao copiar. Veja o console (F8).", -- 36
    ["settings_saved"] = "Configurações salvas!", -- 21

    -- HUD SETTINGS UI
    ["hud_settings"] = "CONFIG. HUD ", -- 12
    ["cat_general"] = "Geral  ", ["cat_voice"] = "Voz  ", ["cat_weapon"] = "Arma  ", ["cat_time"] = "Hora",
    ["cat_date"] = "Data", ["cat_weather"] = "Clima  ", ["cat_playerid"] = "ID Jogador", ["cat_money"] = "Dinhei",
    ["cat_health"] = "Saúde ", ["cat_stamina"] = "Vigor  ", ["cat_water"] = "Água  ", ["cat_hunger"] = "Fome   ",
    ["cat_stress"] = "Stress", ["cat_bath"] = "Banho", ["cat_toilet"] = "Banheir", ["cat_temp"] = "Temperatura ",
    ["div_display"] = "Display", -- 7
    ["div_player_meta"] = "Metabolismo Player", -- 18
    ["div_horse_meta"] = "Metab. Cavalo   ", -- 16
    ["layout_standart"] = "Padrão  ", -- 8
    ["layout_normal"] = "Normal", -- 6
    ["layout_story"] = "Story", -- 5
    ["btn_edit"] = "Editar Posição", -- 14
    ["btn_apply"] = "Aplicar Config.", -- 15
    ["btn_copy"] = "Copiar Config", -- 13
    ["btn_reset"] = "Reset", -- 5
    ["btn_save"] = "Salv", -- 4
    ["grid_size"] = "Tam. Grade", -- 10
    ["cinematic_mode"] = "Modo Cinemático", -- 15
    ["hud_visibility"] = "Visib. do HUD ", -- 14

    -- VISIBILITY LABELS
    ["vis_voice"] = "Visib. da Voz   ", -- 16
    ["vis_weapon"] = "Visib. da Arma   ", -- 17
    ["vis_weapon_right"] = "Arma Mão Direita ", -- 17
    ["vis_weapon_left"] = "Arma Mão Esquer.", -- 16
    ["vis_time"] = "Visib. da Hora ", -- 15
    ["vis_date"] = "Visib. da Data ", -- 15
    ["vis_weather"] = "Visib. do Clima   ", -- 18
    ["vis_playerid"] = "Visib. do ID Player ", -- 20
    ["vis_money"] = "Visib. Dinheiro ", -- 16
    ["vis_health"] = "Visib. da Saúde  ", -- 17
    ["vis_stamina"] = "Visib. do Vigor   ", -- 18
    ["vis_water"] = "Visib. da Água  ", -- 16
    ["vis_hunger"] = "Visib. da Fome   ", -- 17
    ["vis_stress"] = "Visib. do Stress ", -- 17
    ["vis_bath"] = "Visib. do Banho", -- 15
    ["vis_toilet"] = "Visib. Banheiro  ", -- 17
    ["vis_temp"] = "Temperatura", -- 11
    ["vis_horse"] = "HUD Caval", -- 9
    ["vis_horse_health"] = "Saúde Cavalo", -- 12
    ["vis_horse_stamina"] = "Vigor Cavalo ", -- 13

    -- SIZE LABELS
    ["size_voice"] = "Tam. Voz  ", -- 10
    ["size_weapon"] = "Tam. Arma  ", -- 11
    ["size_weapon_right"] = "Tam. Mão Dir.  ", -- 15
    ["size_weapon_left"] = "Tam. Mão Esq. ", -- 14
    ["size_time"] = "Tam. Hora", -- 9
    ["size_date"] = "Tam. Data", -- 9
    ["size_weather"] = "Tam. Clima  ", -- 12
    ["size_playerid"] = "Tam. ID Player", -- 14
    ["size_money"] = "Tam. Dinh.", -- 10
    ["size_health"] = "Tam. Saúde ", -- 11
    ["size_stamina"] = "Tam. Vigor  ", -- 12
    ["size_water"] = "Tam. Água ", -- 10
    ["size_hunger"] = "Tam. Fome  ", -- 11
    ["size_stress"] = "Tam. Stress", -- 11
    ["size_bath"] = "Tam. Banho", -- 10
    ["size_toilet"] = "Tam. Banh. ", -- 11
    ["size_temp"] = "Tam. Temperatura", -- 16
    ["size_h_hud"] = "Tam. HUD Cavalo", -- 15
    ["size_horse_health"] = "Tam. Saúde Cavalo", -- 17
    ["size_horse_stamina"] = "Tam. Vigor Cavalo ", -- 18

    -- COLOR LABELS
    ["color_voice"] = "Cor da Voz ", -- 11
    ["color_time"] = "Cor Hora  ", -- 10
    ["color_date"] = "Cor Data  ", -- 10
    ["color_weather"] = "Cor do Clima ", -- 13
    ["color_playerid"] = "Cor do ID Player", -- 16
    ["color_money"] = "Cor Dinheiro", -- 12
    ["color_health"] = "Cor da Saúde ", -- 13
    ["color_stamina"] = "Cor do Vigor ", -- 13
    ["color_water"] = "Cor da Água", -- 11
    ["color_hunger"] = "Cor da Fome ", -- 12
    ["color_stress"] = "Cor Stress  ", -- 12
    ["color_bath"] = "Cor Banho ", -- 10
    ["color_toilet"] = "Cor Banheiro", -- 12
    ["color_horse_health"] = "Cor Saúde Cavalo  ", -- 18
    ["color_horse_stamina"] = "Cor Vigor Cavalo   ", -- 19
    ["color_temp"] = "Cor Temperatura  ", -- 17
    ["color_h_hud"] = "Cor HUD Cavalo ", -- 15

    -- VOICE SPECIFIC LABELS
    ["voice_follow_head"] = "Seguir Cab.", -- 11
    ["voice_follow_head_desc"] = "Posicionar voz perto da cabeça", -- 30
    ["voice_talk_only"] = "Só Fala  ", -- 9
    ["voice_talk_only_desc"] = "Mostrar voz só ao falar", -- 23

    -- TOGGLE & MISC
    ["toggle_on"] = "LIG",
    ["toggle_off"] = "DES",
    ["desc_hud_settings"] = "Personalize as configurações.", -- 29
    ["desc_general_layouts"] = "Layouts prontos para usar.", -- 26
    ["desc_edit_mode"] = "Ajuste seu HUD livremente.", -- 26
    ["desc_apply_settings"] = "Importar configs de outros.", -- 27
    ["desc_grid_size"] = "Define precisão da grade.", -- 25
    ["btn_edit_pos"] = "Editar Posição",
    ["label_time"] = "Hora:",
    ["label_date"] = "Data:",
    ["label_weather"] = "Clima:",
    ["label_playerid"] = "ID:",
    ["label_money"] = "Saldo:",
    ["unit_celsius"] = "'C",
    ["desc_size_voice"] = "Redimensionar indicador voz.", -- 28
    ["desc_size_weapon"] = "Redimensionar exibição arma.", -- 28
    ["desc_size_weapon_right"] = "Ajustar HUD arma mão direita.", -- 29
    ["desc_size_weapon_left"] = "Ajustar HUD arma mão esquerda.", -- 30
    ["desc_size_time"] = "Redimensionar relógio.", -- 22
    ["desc_size_date"] = "Redimensionar data.", -- 19
    ["desc_size_weather"] = "Redimensionar info clima.", -- 25
    ["desc_size_playerid"] = "Redimensionar texto ID.", -- 23
    ["desc_size_money"] = "Redimensionar saldo.", -- 20
    ["desc_size_health"] = "Redimensionar barra saúde.", -- 26
    ["desc_size_stamina"] = "Redimensionar barra vigor.", -- 26
    ["desc_size_water"] = "Redimensionar indicador sede.", -- 29
    ["desc_size_hunger"] = "Redimensionar barra fome.", -- 25
    ["desc_size_stress"] = "Redimensionar barra stress.", -- 27
    ["desc_size_bath"] = "Redimensionar medidor higiene.", -- 30
    ["desc_size_toilet"] = "Redimensionar barra bexiga.", -- 27
    ["desc_size_temp"] = "Redimensionar temperatura.", -- 26
    ["desc_size_h_hud"] = "Redimensionar painel cavalo.", -- 28
    ["desc_size_h_health"] = "Redimensionar saúde cavalo.", -- 27
    ["desc_size_h_stamina"] = "Redimensionar vigor cavalo.", -- 27
    ["title_general_layouts"] = "Layouts Gerais ", -- 15
    ["title_edit_mode"] = "Modo Edição ", -- 12

    -- WEATHER
    ["WEATHER_blizzard"] = "Nevasca ",
    ["WEATHER_clouds"] = "Nublado",
    ["WEATHER_drizzle"] = "Garoa  ",
    ["WEATHER_fog"] = "Nev",
    ["WEATHER_groundblizzard"] = "Nevasca Rasteira",
    ["WEATHER_hail"] = "Gran",
    ["WEATHER_highpressure"] = "Alta Pressão",
    ["WEATHER_hurricane"] = "Furacão  ",
    ["WEATHER_misty"] = "Nebli",
    ["WEATHER_overcast"] = "Encoberto",
    ["WEATHER_overcastdark"] = "Encob. Escuro",
    ["WEATHER_rain"] = "Chuv",
    ["WEATHER_sandstorm"] = "Tempest.  ",
    ["WEATHER_shower"] = "Chuvis",
    ["WEATHER_sleet"] = "Grani",
    ["WEATHER_snow"] = "Neve",
    ["WEATHER_snowlight"] = "Neve Leve",
    ["WEATHER_sunny"] = "Ensol",
    ["WEATHER_thunder"] = "Trovão ",
    ["WEATHER_thunderstorm"] = "Tempest.Raios",
    ["WEATHER_whiteout"] = "Brancura",
}

-- Helper function to get localized string
function _L(key)
    local lang = Config.Language or "en"
    if Locales[lang] and Locales[lang][key] then
        return Locales[lang][key]
    elseif Locales["en"] and Locales["en"][key] then
        return Locales["en"][key]
    end
    return key
end

-- Export all locales for NUI
function GetAllLocales()
    local lang = Config.Language or "en"
    return Locales[lang] or Locales["en"]
end
