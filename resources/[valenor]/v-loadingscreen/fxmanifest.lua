fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Valenor Studio | <@valenorstudio.com>'
description 'discord.gg/valenorstudio'
version '1.0.0'
lua54 'yes'

server_scripts {
    'game/client/*.lua'
}

server_scripts {
    'game/server/*.lua'
}

shared_scripts {
    'game/shared/*.lua'
}

loadscreen_cursor "yes"
loadscreen 'web/dist/index.html'

escrow_ignore {
    'game/client/*.lua',
    'game/shared/*.lua'
}

files {
    'web/dist/index.html',
    'web/dist/**/*.*',
    'web/dist/*.*',
    'sounds/*.*',
    'images/*.*'
} 
dependency '/assetpacks'