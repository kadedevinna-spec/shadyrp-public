fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Valenor Studio | <@valenorstudio.com>'
description 'discord.gg/valenorstudio'
version '1.0.0'
lua54 'yes'

shared_scripts {
    'config.lua',
}

client_scripts {
    'bridge_client.lua',
}

server_scripts {
    'bridge_server.lua',
}

escrow_ignore {
    'bridge_client.lua',
    'bridge_server.lua',
    'config.lua',
}
dependency '/assetpacks'