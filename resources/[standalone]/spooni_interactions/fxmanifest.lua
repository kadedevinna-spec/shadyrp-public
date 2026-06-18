fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'
lua54 'yes'

author 'Spooni'
description 'Environmental interaction system for furniture and objects with scenarios and animations'
version '8'

shared_scripts {
    '@ox_lib/init.lua',
    '@rsg-core/shared/locale.lua',
    'shared/translation.lua'
}

client_scripts {
    'client/cl_common.lua',
    'shared/config.lua',
    'client/cl_client.lua'
}

server_scripts {
    'server/sv_version.lua'
}

dependencies {
    'rsg-core',
    'ox_lib',
    'ox_target'
}