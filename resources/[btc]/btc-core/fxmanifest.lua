fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

description 'btc-core'
version '2.1.2'
author 'Betiucia'

provides {
    'btc-core'
}

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/core.lua',
    'client/modules/callback.lua',
    'client/modules/framework.lua',
    'client/modules/prompts.lua',
    'client/modules/opensource.lua',
    'client/menu/main_menu.lua',
    'client/modules/dataview.js'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/core.lua',
    'server/modules/callback.lua',
    'server/modules/framework.lua',
    'server/modules/utils.lua',
    'server/versionchecker.lua',
}

escrow_ignore {
    'config.lua',
    'client/modules/opensource.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/images/*.png',
    'html/images/layout/*.png',
    'html/layoutNUI/*.png',
    'html/images/layout/*.svg',
    'html/fonts/*.ttf'
}

exports {
    'GetCore',
    'openMenu',
    'closeMenu',
    'showProgressBar'
}

lua54 'yes'

dependency '/assetpacks'
dependency '/assetpacks-redm'