fx_version 'cerulean'
game 'rdr3'

author 'Valenor Studio | <@valenorstudio.com>'
description 'discord.gg/valenorstudio'
version '1.0.0'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'

shared_scripts {
    "config.lua",
    "locales.lua",
    "callbacks.lua",
    "shared/framework/client.lua",
}

client_scripts {
    'client/structs.js',
    'client/utils.lua',
    'client/consumption.lua',
    'client/main.lua',
    'client/bathing.lua',
    'client/washing.lua',
    'client/poison.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'shared/framework/server.lua',
    'server/main.lua'
}

files {
    "html/**"
}

dependencies {
    'oxmysql',
    'weathersync',
}

ui_page 'html/index.html'

escrow_ignore {
    "config.lua",
    "locales.lua",
    "callbacks.lua",
    "shared/framework/*.lua",
}
dependency '/assetpacks'
dependency '/assetpacks-redm'