fx_version 'cerulean'
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

author 'Midnight Code'
name 'loading screen'
description 'Midnight Code Loading Screen for RedM vorp core'

client_scripts { "config.lua", "client/main.lua" }
server_scripts { "config_server.lua", "server/main.lua" }

files {
    'web/**/*'
}

loadscreen_manual_shutdown "yes"
loadscreen 'web/index.html'
loadscreen_cursor "yes"

ui_page 'web/index.html'

escrow_ignore { "config.lua", "config_server.lua" }

dependency '/assetpacks'