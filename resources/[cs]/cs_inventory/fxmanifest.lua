fx_version 'cerulean'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
author 'CS Development'
name 'cs_inventory'
description 'CS Custom Inventory - Visual replacement for vorp_inventory NUI'
version '1.0.0'

lua54 'yes'

client_scripts {
    'config.lua',
    'lang/*.lua',
    'client/main.lua',
}

server_scripts {
    'server/trade.lua',
}

ui_page 'html/index.html'

files {
    'html/**/*',
}

escrow_ignore {
    'config.lua',
    'lang/*'
}

dependency '/assetpacks'
dependency '/assetpacks-redm'