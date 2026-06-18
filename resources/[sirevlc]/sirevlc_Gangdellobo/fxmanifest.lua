fx_version "adamant"
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."
lua54 'yes'

client_scripts {
    'client/config.lua',
    'client/client.lua',
}

server_scripts {
	'client/config.lua',
    'server.lua',
}

escrow_ignore {
 'client/config.lua',
}

dependency '/assetpacks'