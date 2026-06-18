lua54 'yes'
fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

name        'FX-Camping'
author      'Fixitfy'
version     '1.3'
description 'Advanced Camping system by Fixitfy'

shared_scripts {
    'config.lua',
    'config_wardrobe.lua',
    'locales.lua',
    'config_items.lua',
    'config_tutorial.lua',
    'framework/frameworks.lua',
}

client_scripts {
    'client/functions.lua',
    'client/main.lua',
    'client/camp.lua',
    'client/mycamp.lua',
    'client/camps_admin.lua',
    'client/test_wagon.lua',
    'client/createcamp.lua',
    'client/campinfo.lua',
    'client/favorites.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/camp.lua',
    'server/favorites.lua',
    'versionchecker.lua',
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/main.js',
    'ui/assets/**',
    'favorites.json',
}

escrow_ignore {
    'config.lua',
    'config_wardrobe.lua',
    'locales.lua',
    'config_items.lua',
    'config_tutorial.lua',
    'framework/frameworks.lua',
}

dependency '/assetpacks'
dependency '/assetpacks-redm'