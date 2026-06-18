fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'
lua54 'yes'

name 'MX-npcmedic'
description 'Médico NPC / chamada de emergência (RSG & VORP)'
version '1.0.0'
author 'MX'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'shared/framework.lua',
}

client_scripts {
    'client/client.lua',
}

server_scripts {
    'server/server.lua',
}

dependencies {
    'ox_lib',
}

dependency '/assetpacks'