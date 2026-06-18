fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'
lua54 'yes'

name 'MX-Ranch'
description 'Full ranch system — oxmysql, VORP/RSG (see README.md)'
version '2.2.0'
author 'MX-SCRIPTS'

ui_page 'html/index.html'

files {
    'locales/en.json',
    'locales/pt.json',
    'html/index.html',
    'html/style.css',
    'html/admin.css',
    'html/collect-minigame.css',
    'html/i18n.js',
    'html/collect-minigame.js',
    'html/script.js',
    'html/admin.js',
    --- Ranch art + MX-Admin panel textures
    'html/img/*.png',
    'html/audio/minigameselect2.mp3',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'shared/defaults.lua',
    'shared/locale.lua',
}
escrow_ignore {
    'config.lua',
    'shared/defaults.lua',
}
client_scripts {
    'client/core.lua',
    'client/ranch.lua',
    'client/walk.lua',
    'client/sell_yard.lua',
    'client/nui.lua',
    'client/admin.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/framework.lua',
    'server/security.lua',
    'server/core.lua',
    'server/logs.lua',
    'server/ranch.lua',
    'server/net.lua',
}

dependencies {
    'ox_lib',
    'oxmysql',
}

dependency '/assetpacks'
dependency '/assetpacks-redm'