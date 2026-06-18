fx_version "cerulean"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
description 'Fixitfy Accessories System'
author "Fixitfy Development"
version "1.1"

ui_page 'ui/index.html'

shared_scripts {
    'config.lua',
    'config_items.lua',
    'config_shops.lua',
    'locales.lua',
    'frameworks.lua',
}

files {
    'ui/index.html',
    'ui/style.css',
    'ui/script.js',
    'ui/assets/**/*'
}

client_scripts {
    'libs/objects.lua',
    'c/functions.lua',
    'c/c.lua',
    'c/shops.lua',
}
server_script {
    'libs/animlib.lua',
    's/s.lua',
    's/shops.lua',
    'versionchecker.lua'
}

escrow_ignore {
    'config_items.lua',
    'config.lua',
    'config_shops.lua',
    'frameworks.lua',
    'locales.lua',
    'reload_items.json',
}

lua54 'yes'
dependency '/assetpacks'
dependency '/assetpacks'
dependency '/assetpacks-redm'