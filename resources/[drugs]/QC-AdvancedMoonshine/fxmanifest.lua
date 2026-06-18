fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Quantum Projects'
description 'Quantum Projects Moonshine | Dev: Artmines'
quantum_discord 'https://discord.gg/kJ8ZrGM8TS'
version '2.0.2'

-- Shared
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'config.shacks.lua'
}

-- Server
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
    'server/modules/*.lua'
}

-- Client
client_scripts {
    'client/client.lua',
    'client/modules/*.lua'
}

dependencies {
    'ox_lib',
    'oxmysql',
    'rsg-core',
    'rco-dialogs',
    'xsound'
}

escrow_ignore {
    'config.lua',
    'config.shacks.lua',
    'locales/*.json',
    'README.md',
    'CHANGELOG.md',
    'install/*',
    'LICENSE.md'
}

files {
    'ui/dist/**/*',
    'locales/*.json'
}

lua54 'yes'
ui_page 'ui/dist/index.html'
use_experimental_fxv2_oal 'yes'
dependency '/assetpacks'