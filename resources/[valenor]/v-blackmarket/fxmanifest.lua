fx_version 'adamant'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'


author 'Valenor Studio'
description 'Black Market script for your RedM Servers'
version '1.0.0'
lua54 'yes'


client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts {
    'config.lua',
    'server.lua'
}

ui_page 'index.html'

files {
    'index.html',
    'style.css',
    'script.js',
    'images/*.png'
}


escrow_ignore {
    'config.lua'
}

exports {
    'OpenBlackMarket',
    'CloseBlackMarket'
}

dependency '/assetpacks'
dependency '/assetpacks'