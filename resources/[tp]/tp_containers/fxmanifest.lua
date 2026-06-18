fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Nosmakos'
description 'Titans Productions - Container Storages'
version '1.3.1'

ui_page 'html/index.html'

shared_scripts {
    'config.lua',
    'locales.lua',
    'shared/tp-shared_main.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

files { 'html/**/*' }

escrow_ignore {
    'config.lua',
    'locales.lua',
    'server/tp-server_functions_escrow.lua',
    'shared/tp-shared_main.lua',
}

dependencies { 'tp_libs' }

lua54 'yes'
dependency '/assetpacks'