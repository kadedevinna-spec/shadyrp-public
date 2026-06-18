fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Valenor Studio | <@valenorstudio.com>'
description 'discord.gg/valenorstudio'
version '1.5.2'
lua54 'yes'

ui_page {
	'web/dist/index.html' --  http://localhost:5173/
}

shared_scripts { 
	'config.lua',
}

client_scripts {
    'bridge_client.lua',
    'client.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'bridge_server.lua',
    'server.lua'
}

files {
	'web/dist/**/*',
}

escrow_ignore {
    "config.lua",
    "bridge_server.lua",
    "bridge_client.lua",
    "client.lua",
    "server.lua"
}
dependency '/assetpacks'