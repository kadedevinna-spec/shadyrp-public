fx_version 'cerulean'
game 'rdr3'
author 'Valenor Studio'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
description 'Identification Card Script for RedM'

client_scripts {
    'client.lua'
}

server_scripts {
    'shared_items.lua',
    'server.lua'
}

shared_scripts {
    'config.lua'
}

ui_page {
    'html/index.html'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/img/*.png',
    'html/img/*.jpg',
}

escrow_ignore {
    'server.lua',
    'client.lua',
    'config.lua',
    'shared_items.lua'
}

dependencies {
    'oxmysql'
}
dependency '/assetpacks'
dependency '/assetpacks'