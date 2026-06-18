fx_version 'adamant'
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'

author 'Mosquito'
version '1.0.0'


client_scripts { 'config.lua', 'checker_func.lua', 'client.lua' }
server_scripts { 'server.lua' }

escrow_ignore {
    'config.lua',
    'checker_func.lua',
    'README.md'
}

exports {
    'combatroll'
}

dependency '/assetpacks'
dependency '/assetpacks-redm'