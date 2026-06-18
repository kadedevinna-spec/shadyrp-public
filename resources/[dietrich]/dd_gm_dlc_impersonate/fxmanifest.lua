rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
fx_version 'cerulean'
game { 'gta5', 'rdr3' }
lua54 'yes'

author 'Dietrich Development'
version '1.0.0'

description 'Dietrich Development Gamemaster DLC for Impersonate'

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua',
    '@dd_gamemaster/core/server/crypto.lua'
}

dependency '/assetpacks'