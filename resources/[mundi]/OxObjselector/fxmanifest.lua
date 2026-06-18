fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'
author 'Mundi'
version '1.0.3'
description 'Configurable object interaction system using ox_target'

shared_scripts {
    'config.lua',
    'bath_config.lua',
    'locales/locale.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'locales/sr.lua',
    'locales/es.lua',
    'locales/de.lua',
    'locales/pl.lua',
    'locales/pt.lua'
}

client_scripts {
    'client/bathing.lua',
    'client/items.lua',
    'structs.js',
    'client/interactions.lua',
    'client/canteen.lua'
}

server_scripts {
    'server/bathing.lua',
    'server/items.lua',
    'server/canteen.lua'
}

files {
    'README.md'
}

dependencies {
    'ox_target',
    'ox_lib'

    'vorp_core',
    'vorp_inventory',
    'rsg-core',
    'rsg-inventory'
}

escrow_ignore {
    'config.lua',
    'bath_config.lua',
    'locales/*.lua',
    'README.md',
    'sql/*'
}
dependency '/assetpacks'