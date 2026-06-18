fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

name 'M-ServerGuard'
description 'server monitoring, analytics & moderation tool & a little bit of everything on top'
author 'Mundi'
version '1.0.1'
lua54 'yes'
shared_scripts {
    'configs/config.lua',
    'configs/anticheat.lua',
    'configs/webhooks.lua',
    'configs/teleports.lua',
    'configs/web.lua',
    'bridge/shared.lua',
    'languages/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'bridge/server.lua',
    'server/database.lua',
    'server/main.lua',
    'server/player_monitor.lua',
    'server/economy_monitor.lua',
    'server/anticheat.lua',
    'server/resource_monitor.lua',
    'server/admin_actions.lua',
    'server/alerts.lua',
    'server/analytics.lua',
    'server/bans.lua',
    'server/chat_monitor.lua',
    'server/server_management.lua',
    'server/reports.lua',
    'server/leaderboard.lua',
    'server/screening.lua',
    'server/whitelist.lua',
    'server/txadmin_sync.lua',
    'server/extended_features.lua',
    'server/web_server.lua',
    'server/web_server_ext.lua',
    'server/api.lua',
}

client_scripts {
    'bridge/client.lua',
    'client/main.lua',
    'client/anticheat.lua',
}

ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/css/style.css',
    'nui/js/app.js',
    'nui/js/utils.js',
    'nui/lib/leaflet/leaflet.css',
    'nui/lib/leaflet/leaflet.js',
    'nui/lib/fa/all.min.css',
    'nui/lib/webfonts/fa-brands-400.woff2',
    'nui/lib/webfonts/fa-regular-400.woff2',
    'nui/lib/webfonts/fa-solid-900.woff2',
    'nui/lib/webfonts/fa-v4compatibility.woff2',
}

dependencies {
    'oxmysql',
}

escrow_ignore {
    'configs/config.lua',
    'configs/anticheat.lua',
    'configs/webhooks.lua',
    'configs/teleports.lua',
    'configs/web.lua',
    'languages/*.lua',
    'sql/M-ServerGuard.sql',
    'README.md',
    'version*.md',
    'fxmanifest.lua',
}

dependency '/assetpacks'
dependency '/assetpacks-redm'