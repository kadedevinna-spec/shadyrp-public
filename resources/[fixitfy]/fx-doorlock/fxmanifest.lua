lua54 'yes'
fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'


name        'FX-Doorlock'
author      'Fixitfy'
version     '1.1'
description 'Advanced doorlock system by Fixitfy'

shared_scripts {
    'config.lua',
    'config_customdoor.lua',
    'saved_doors.lua',
    'saved_custom_doors.lua',
    'framework/frameworks.lua',
}

client_scripts {
    'doorhashes.lua',
    'client/opensource.lua',
    'client/functions.lua',
    'client/customdoor.lua',
    'client/main.lua',
}

server_scripts {
    'versionchecker.lua',
    'server/main.lua',
    'server/customdoor.lua',
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/style.css',
    'ui/main.js',
    'ui/assets/**',
}

escrow_ignore {
    'config.lua',
    'versionchecker.lua',
    'framework/frameworks.lua',
    'config_customdoor.lua',
    'saved_doors.lua',
    'saved_custom_doors.lua',
    'client/opensource.lua'
}
dependency '/assetpacks'
dependency '/assetpacks-redm'