game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'

client_scripts {
    'client/config.lua',
    'client/client.lua',
}

server_scripts {
    'server/server.lua',
	'client/config.lua',
	'@mysql-async/lib/MySQL.lua',
}


escrow_ignore {
    'client/config.lua',
}
dependency '/assetpacks'
dependency '/assetpacks-redm'