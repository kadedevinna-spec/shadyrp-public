rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
fx_version 'cerulean'
game 'rdr3'
lua54 'yes'

author 'Dietrich Development'
version '1.0.0'

description 'Dietrich Development Gamemaster DLC for Elements (Fire, Lightning)'

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua',
    '@dd_gamemaster/core/server/crypto.lua'
}

dependency '/assetpacks'