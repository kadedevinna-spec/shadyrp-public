Locales['en'] = {

    -- =====================================================================
    -- GENERAL
    -- =====================================================================
    prompt_start_raid        = 'Start Raid',
    prompt_open_loot         = 'Open Loot Chest',
    prompt_loot_searching    = 'Searching chest...',
    prompt_talk              = 'Talk',
    prompt_disable_alarm     = 'Disable Alarm',
    prompt_search_loot_chest = 'Search Loot Chest',
    prompt_inspect_vault     = 'Inspect Vault',
    prompt_search_vault      = 'Search Vault',
    prompt_place_dynamite    = 'Place Dynamite',
    prompt_interact_wagon    = 'Interact with Wagon',
    prompt_route_informant   = 'Route Informant',
    prompt_reading_map       = 'Reading route plans...',
    prompt_pick_up           = 'Pick Up %s',

    -- =====================================================================
    -- TRAVEL / APPROACH
    -- =====================================================================
    travel_go_to_location    = 'Head to the marked location to begin.',
    travel_timeout           = 'You took too long to reach the raid location.',

    -- =====================================================================
    -- RAID FLOW
    -- =====================================================================
    area_clear               = 'The area is clear.',
    area_disturbance         = 'Something feels off in this area.',
    area_command_taken       = 'You have taken control of the area.',

    cavalry_incoming         = 'Cavalry reinforcements are on their way.',
    wave_incoming            = 'Wave %d incoming.',
    raid_failed_abandoned    = 'The raid has failed. Nobody made it.',
    law_fled                 = 'Their leader has fled.',
    raid_resumed             = 'Raid resumed! You have reconnected.',
    raid_resumed             = 'Raid resumed! You have reconnected.',
    raid_resumed             = 'Raid resumed! You have reconnected.',

    -- =====================================================================
    -- HOST / PARTY
    -- =====================================================================
    now_host                 = 'You are now leading the raid.',
    host_transferred         = 'Raid control handed off (%s).',
    missing_required_item    = 'You need: %s',

    -- =====================================================================
    -- LOOT CHESTS
    -- =====================================================================
    loot_chest_locked        = 'The lock is jammed. Try a different approach.',
    loot_chest_not_found     = 'You cannot find the chest.',
    loot_chest_empty         = 'The container is empty.',
    loot_chest_looted        = 'This chest has already been looted.',
    loot_chest_not_yet       = 'The area is not clear enough to loot.',
    loot_too_far             = 'Get closer to the loot container.',
    loot_found_cash          = 'Found $%s.',
    loot_found_moneybag      = 'Found a money bag worth $%s.',
    loot_found_item          = 'Found: %s.',
    loot_found_nothing       = 'There was nothing worth taking.',

    -- =====================================================================
    -- LOCKPICK
    -- =====================================================================
    lockpick_need_item       = 'You need a %s to attempt this.',
    lockpick_broke           = 'Your %s broke. You will need a replacement.',

    -- =====================================================================
    -- VAULT
    -- =====================================================================
    vault_place_dynamite     = 'Set the dynamite on the vault.',
    vault_fuse_lit           = 'Fuse lit! Clear the area!',
    vault_moved_away         = 'You stepped away from the fuse.',
    vault_blown_open         = 'The vault has been blown open!',
    vault_searching          = 'Searching the vault...',
    vault_need_dynamite      = 'You need dynamite to open this vault.',
    vault_cancelled          = 'Dynamite placement cancelled.',

    -- =====================================================================
    -- ALARM
    -- =====================================================================
    alarm_disabled           = 'Alarm silenced.',
    alarm_failed             = 'Could not disable the alarm.',

    -- =====================================================================
    -- SERVER CHECKS (sent to client from server)
    -- =====================================================================
    check_spawn_failed       = 'Spawn failed for model: %s. Check server logs.',
    check_invalid_location   = 'That location is not valid.',
    check_not_your_fight     = 'This is not your fight.',
    check_raid_active        = 'Another raid is already underway.',
    check_cooldown           = 'The %s is still cooling down. %s minutes left.',
    check_too_far            = 'You need to be closer to start a raid.',
    check_friendly_job       = 'Your line of work keeps you out of this.',
    check_not_enough_law     = 'Not enough law around. Come back later.',
    check_ownership_error    = 'Some entities could not transfer ownership.',
    check_ownership_ok       = 'Ownership transfer complete.',
    check_reinforcements     = 'Enemy reinforcements incoming!',
    check_boundary_occupied  = 'The area is occupied. Clear it before attacking.',
    check_too_many_law       = 'Too many badges around. Come back when it\'s safer.',
    check_jurisdiction_active = 'Another raid is already active in this jurisdiction (%s). Wait for it to end.',
    check_cooldown_area      = 'The %s guards are on high alert. Return in %d minutes.',
    check_need_item          = 'You need a %s to start this raid.',
    check_not_enough_law_count = 'Not enough law online. This raid requires %d %s officers (%d online).',
    check_boundary_occupied  = 'The area is occupied. Clear it before attacking.',
    check_too_many_law       = 'Too many badges around. Come back when it\'s safer.',
    check_jurisdiction_active = 'Another raid is already active in this jurisdiction (%s). Wait for it to end.',
    check_cooldown_area      = 'The %s guards are on high alert. Return in %d minutes.',
    check_need_item          = 'You need a %s to start this raid.',
    check_not_enough_law_count = 'Not enough law online. This raid requires %d %s officers (%d online).',
    check_boundary_occupied  = 'The area is occupied. Clear it before attacking.',
    check_too_many_law       = 'Too many badges around. Come back when it\'s safer.',
    check_jurisdiction_active = 'Another raid is already active in this jurisdiction (%s). Wait for it to end.',
    check_cooldown_area      = 'The %s guards are on high alert. Return in %d minutes.',
    check_need_item          = 'You need a %s to start this raid.',
    check_not_enough_law_count = 'Not enough law online. This raid requires %d %s officers (%d online).',

    -- =====================================================================
    -- MINIGAME ERRORS
    -- =====================================================================
    minigame_unavailable     = 'Minigame system is not available.',
    minigame_error           = 'Something went wrong with the minigame.',
    minigame_timeout         = 'The minigame timed out.',

    -- =====================================================================
    -- BANK WAGON
    -- =====================================================================
    bw_already_active        = 'You already have an active bank wagon robbery in progress.',
    bw_no_route_info         = "This contact doesn't have route information.",
    bw_no_jurisdiction       = 'You need to be in a jurisdiction to use this route plan. Currently in: %s',
    bw_no_routes             = 'No routes available in %s.',
    bw_anim_failed           = 'Failed to load animation. Try again.',
    bw_prop_failed           = 'Failed to load prop. Try again.',
    bw_invalid_route         = 'Invalid route selected.',
    bw_route_unavailable     = 'This route is not available in your current location.',
    bw_admin_cooldown_bypass = '[Admin] Cooldown bypassed.',
    bw_spawn_failed          = 'Wagon failed to spawn. Your route plans have been returned.',
    bw_no_moneybag           = "You don't have a money bag.",
    bw_takeover              = "You've taken over a Bank Wagon robbery!",

    -- =====================================================================
    -- BANK WAGON — criminal notifications
    -- =====================================================================
    bw_criminal_cancelled       = 'Robbery cancelled.',
    bw_criminal_missing_item    = 'You need Route Plans to start this robbery.',
    bw_criminal_route_cooldown  = 'This route was recently hit. Wait %d more minutes before attempting it again.',
    bw_wagon_spotted            = 'Bank Wagon spotted! Move to intercept!',
    bw_missing_dynamite         = 'You need dynamite to blow the wagon!',
    bw_wagon_moved              = 'Wagon moved - placement cancelled!',
    bw_fuse_active              = 'Fuse burning - get clear!',
    bw_criminal_wagon_destroyed = 'The wagon was destroyed before you could loot it!',
    bw_wagon_escaped            = 'The wagon escaped!',
    bw_heat_dissipating         = "The wagon's metal is too hot! Wait for it to cool. (%d seconds remaining)",
    bw_heat_dissipated          = 'The metal has cooled. You can now prepare the dynamite!',
    bw_preparing_dynamite       = 'Preparing explosive charges...',
    bw_dynamite_ready           = 'Dynamite prepared and placed!',
    bw_loot_collected           = 'Collected %dx %s',
    bw_loot_taken               = 'Someone already took that!',

    -- =====================================================================
    -- BANK WAGON — law enforcement notifications
    -- =====================================================================
    bw_law_alert_initial        = '~r~Bank Wagon under attack!~s~',
    bw_law_alert_update         = '~y~Last spotted:~s~ %s',
    bw_law_at_destination       = '~y~Wagon at destination! Dismount to complete the delivery.',
    bw_law_delivery_complete    = '~g~Delivery Complete! The Central Bank sends their regards. Excellent work.',
    bw_law_wagon_recovered      = '~g~Bank wagon recovered!~s~ Deliver it to the marked destination.',
    bw_law_delivered_criminal   = '~r~Failed!~s~ The wagon reached its destination.',
    bw_law_delivered_npc        = 'The bank wagon successfully reached its destination.',
    bw_law_wagon_destroyed      = 'The wagon was destroyed before reaching its destination.',

    -- =====================================================================
    -- BANK WAGON — proximity / spawn / gameplay
    -- =====================================================================
    bw_en_route                 = 'Bank wagon en route. Track it on your map.',
    bw_nearby                   = 'Bank wagon nearby!',
    bw_spawned                  = 'Bank wagon spawned!',
    bw_guards_spotted           = '~r~The guards have spotted you!',
    bw_wagon_destroyed_early    = 'The wagon was destroyed!',
    bw_escorts_lost             = "You've left the escorts behind! Prepare the dynamite.",
    bw_guards_eliminated        = 'Guards eliminated! Wait %d seconds for the wagon to cool before placing explosives.',
    bw_guards_enough            = 'Enough guards eliminated! Wait %d seconds for the wagon to cool before placing explosives.',
    bw_placement_died           = 'Placement interrupted - you died!',
    bw_placement_movement       = 'Placement cancelled - movement detected.',
    bw_placement_interrupted    = 'Placement cancelled - action interrupted.',

    -- =====================================================================
    -- BANK WAGON — job restrictions / admin
    -- =====================================================================
    bw_law_denial               = "It's tempting to intercept, but you're better off staying out of it.",
    bw_fence_not_allowed        = "This operation is restricted - your line of work doesn't qualify.",
    bw_admin_end_all            = 'All bank wagon robberies have been ended.',
    bw_admin_end_one            = 'Bank wagon robbery #%d has been ended.',

    -- =====================================================================
    -- RAIDS — job whitelist
    -- =====================================================================
    check_allowed_jobs          = "This raid is restricted - your line of work doesn't qualify.",

    -- =====================================================================
    -- ADMIN / DEBUG (never seen by normal players)
    -- =====================================================================
    admin_no_permission      = 'You do not have permission to do that.',
    admin_active_raids       = 'Active raids: %s',
    admin_wave_triggered     = 'Triggered next wave for raid %s.',
    admin_wave_usage         = 'Usage: /testraidwave <raidId>',
    admin_loot_unlocked      = 'Loot unlocked for raid %s.',
    admin_raid_ended         = 'Raid %s ended.',
    admin_cooldown_reset     = 'Cooldown reset for: %s',
    admin_cooldown_reset_all = 'All cooldowns reset.',
}
