fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Valenor Studio | <@valenorstudio.com>'
description 'discord.gg/valenorstudio'
version '1.0.2'
lua54 'yes'

ui_page {
	'web/dist/index.html' --  http://localhost:5173/
}

shared_scripts { 
	'config.lua',
}

client_scripts {
    'client.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server.lua',	
}

files {
	'web/dist/**/*',
}

escrow_ignore {
    "config.lua",
    "server.lua",
    "client.lua"
}
dependency '/assetpacks'
dependency '/assetpacks-redm'