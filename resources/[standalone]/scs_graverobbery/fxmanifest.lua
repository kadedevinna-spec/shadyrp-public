fx_version 'cerulean'
game 'rdr3'
author 'ScytheCode Studios'
description 'Grave Robbery System'
version '1.0.5'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
}

client_scripts {
    'client/open_functions.lua',
    'client/prompt.lua',
    'client/cl_main.lua',
    'client/functions.lua'
}

server_scripts {
    'server/open_functions.lua',
    'server/functions.lua',
    'server/sv_main.lua'
}

files {
    'locales/*.json',
}

ox_libs {
    'locale',
}

dependencies {
    'ox_lib',
    'rsg-core',
}

escrow_ignore {
    'shared/config.lua',
    'client/open_functions.lua',
    'client/prompt.lua',
    'locales/*.json',
    'server/open_functions.lua',
    'install/**',
    'README.md',
    'LICENSE',
}

lua54 'yes'
dependency '/assetpacks'