fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'
lua54 'yes'

author 'Mundi'
description 'M-Telegrams The Ultimate Telegram System for VORP/RSG'
version '1.1.1'

dependencies {
    'ox_lib',
    'oxmysql',
    -- Framework dependencies are loaded dynamically based on Config.Framework
    -- VORP: vorp_core, vorp_inventory
    -- RSG:  rsg-core, rsg-inventory
}

ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/style.css',
    'nui/style_parcels_birds.css',
    'nui/script.js',
    'nui/script_parcels_birds.js',
    'nui/img/**/*.png',
    'nui/img/*.png',
    'nui/img/*.wav',
    'nui/sounds/*.wav',
    'nui/fonts/*.ttf',
    'nui/fonts/*.woff',
    'nui/fonts/*.woff2',
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/notifications.lua',
    'shared/locale.lua',
}

client_scripts {
    'client/framework.lua',
    'client/nui.lua',
    'client/stations.lua',
    'client/notifications.lua',
    'client/main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/framework.lua',
    'server/database.lua',
    'server/telegrams.lua',
    'server/contacts.lua',
    'server/companies.lua',
    'server/parcels.lua',
    'server/birds.lua',
    'server/admin.lua',
    'server/webhooks.lua',
    'server/main.lua',
}

escrow_ignore {
    'shared/config.lua',
    'shared/notifications.lua',
    'shared/locale.lua',
    'sql/database.sql',
    'fxmanifest.lua',
}

dependency '/assetpacks'
dependency '/assetpacks-redm'