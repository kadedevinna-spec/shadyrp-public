fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Valenor Studio | <@valenorstudio.com>'
description 'discord.gg/valenorstudio'
version '1.0.3'
lua54 'yes'

client_scripts {
    'game/client/*.*',
    'game/shared/Shared.lua',
}

server_scripts {
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
    'game/client/*.*',
    'game/server/*.*',
    'game/shared/*.lua',
}
dependency '/assetpacks'
dependency '/assetpacks-redm'