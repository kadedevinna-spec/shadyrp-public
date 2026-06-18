fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Mundi'
description 'Backpack inventory containers - VORP & RSG Compatible'
version '1.0.2'

shared_scripts {
    'config.lua',
    'locale.lua',
    'notifications.lua',
    'bridge/shared.lua'
}

client_scripts {
    'bridge/client.lua',
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'bridge/server.lua',
    'server/main.lua'
}

lua54 'yes'

dependency 'vorp_core'
dependency 'vorp_inventory'
dependency 'rsg-core'
dependency 'rsg-inventory'


escrow_ignore {
    'config.lua',
    'locale.lua',
    'notifications.lua',
    'sql/*',
    'Icons/*',
    'README.md'
}

dependency '/assetpacks'