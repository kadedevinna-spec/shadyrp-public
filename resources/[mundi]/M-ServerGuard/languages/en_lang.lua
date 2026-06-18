Locales['en'] = {
    -- General
    ['checking_player']       = 'Checking player...',
    ['steam_required']        = 'Steam identifier is required to join this server.',
    ['no_permission']         = 'You do not have permission to do this.',
    ['player_not_found']      = 'Player not found.',
    ['no_reason']             = 'No reason provided.',
    ['invalid_usage']         = 'Invalid command usage.',

    -- Ban Messages
    ['banned_message']        = 'You are banned from this server.',
    ['reason']                = 'Reason',
    ['expires']               = 'Expires',
    ['permanent']             = 'Permanent',
    ['ban_appeal']            = 'You may appeal this ban at the server\'s Discord.',
    ['no_active_ban']         = 'No active ban found for this player.',

    -- Admin Actions
    ['kicked_by_admin']       = 'You were kicked by an administrator.',
    ['player_kicked']         = 'Player %s has been kicked.',
    ['player_banned']         = 'Player %s has been banned.',
    ['player_unbanned']       = 'Player has been unbanned.',
    ['you_were_warned']       = 'You have received a warning',
    ['player_warned']         = 'Player %s has been warned.',
    ['player_frozen']         = 'Player %s has been frozen.',
    ['player_unfrozen']       = 'Player %s has been unfrozen.',
    ['you_are_frozen']        = 'You have been frozen by an administrator.',
    ['you_are_unfrozen']      = 'You have been unfrozen.',
    ['you_were_revived']      = 'You have been revived by an administrator.',
    ['spectate_started']      = 'Now spectating player. Press Backspace to stop.',
    ['spectate_stopped']      = 'Spectating ended.',

    -- Command Usage
    ['usage_kick']            = 'Usage: /gkick [id] [reason]',
    ['usage_ban']             = 'Usage: /gban [id] [duration] [reason]',
    ['usage_unban']           = 'Usage: /gunban [steam_identifier]',
    ['usage_warn']            = 'Usage: /gwarn [id] [reason]',
    ['usage_goto']            = 'Usage: /ggoto [id]',
    ['usage_bring']           = 'Usage: /gbring [id]',
    ['usage_report']          = 'Usage: /report [message]',
    ['usage_preport']         = 'Usage: /preport [player_id] [reason]',

    -- Reports
    ['report_submitted']      = 'Report submitted. Use /myreports to track replies.',
    ['report_cooldown']       = 'Please wait before submitting another report.',

    -- Anti-Cheat
    ['kicked_anticheat']      = 'You were removed by the anti-cheat system.',
    ['detection_teleport']    = 'Teleport detected',
    ['detection_speedhack']   = 'Speed hack detected',
    ['detection_godmode']     = 'God mode detected',
    ['detection_explosion']   = 'Explosion spam detected',
    ['detection_eventspam']   = 'Event spam detected',
    ['detection_resource']    = 'Unauthorized resource detected',
    ['detection_blacklisted'] = 'Blacklisted event triggered',
    ['detection_money']       = 'Money anomaly detected',
    ['detection_item_dupe']   = 'Item duplication suspected',

    -- Alerts
    ['alert_economy_anomaly'] = 'Economy anomaly: %s received %s unexpectedly.',
    ['alert_item_duplication']= 'Possible item duplication: %s received %sx %s.',
    ['alert_chat_spam']       = 'Chat spam detected from %s.',
    ['alert_new_resource']    = 'New resource started: %s',
    ['alert_resource_stopped']= 'Resource stopped: %s',
    ['alert_player_flagged']  = 'Player %s has been flagged: %s',
    ['alert_large_txn']       = 'Large transaction detected: %s - %s %s',

    -- Dashboard
    ['dashboard_title']       = 'M-ServerGuard Dashboard',
    ['players_online']        = 'Players Online',
    ['peak_players']          = 'Peak Players',
    ['total_unique']          = 'Total Unique Players',
    ['active_bans']           = 'Active Bans',
    ['detections_today']      = 'Detections Today',
    ['alerts_today']          = 'Alerts Today',
    ['economy_txns']          = 'Economy Transactions',
    ['total_resources']       = 'Total Resources',

    -- Misc
    ['server_guard_started']  = 'M-ServerGuard v%s initialized — Framework: %s',
    ['database_initialized']  = 'Database tables initialized.',
    ['resources_scanned']     = 'Scanned %s resources (%s categories).',
    ['daily_summary']         = 'Daily summary generated.',
    ['data_cleanup']          = 'Old data cleanup complete (%s days retention).',

    -- Screening
    ['screening_steam']        = 'Verifying Steam account...',
    ['screening_alts']         = 'Checking account history...',
    ['screening_denied']       = 'Connection denied: your account has been flagged by our security system. Contact an admin if you believe this is an error.',
}
