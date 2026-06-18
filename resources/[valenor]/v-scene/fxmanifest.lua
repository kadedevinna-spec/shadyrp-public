fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Valenor Studio | <@valenorstudio.com>'
description 'discord.gg/valenorstudio'
version '1.0.0'
lua54 'yes'

client_scripts {
    'game/bridge/config.lua',
    'game/bridge/shared.lua',
    'game/bridge/vorp/client.lua',
    'game/bridge/rsg/client.lua',
    'game/bridge/custom/client.lua',
    'game/bridge/client.lua',
    'game/client/Utils.lua',
    'game/client/Functions.lua',
    'game/client/Client.lua'
}

server_scripts {
    'game/bridge/config.lua',
    'game/bridge/shared.lua',
    'game/bridge/vorp/server.lua',
    'game/bridge/rsg/server.lua',
    'game/bridge/custom/server.lua',
    'game/bridge/server.lua',
    'game/server/*.*'
}

shared_scripts {
    'game/shared/*.*'
}

ui_page 'web/dist/index.html'

files {
    'web/dist/index.html',
    'web/dist/**/*.*',
    'web/dist/*.*'
}

escrow_ignore {
    'game/bridge/config.lua',
    'game/bridge/shared.lua',
    'game/bridge/vorp/client.lua',
    'game/bridge/rsg/client.lua',
    'game/bridge/custom/client.lua',
    'game/bridge/client.lua',
    'game/bridge/config.lua',
    'game/bridge/shared.lua',
    'game/bridge/vorp/server.lua',
    'game/bridge/rsg/server.lua',
    'game/bridge/custom/server.lua',
    'game/bridge/server.lua',
    'game/shared/*.*',
    'game/client/Utils.lua',
    'game/client/Functions.lua',
    'game/client/Client.lua',
    'game/server/*.*'
}


dependency '/assetpacks'