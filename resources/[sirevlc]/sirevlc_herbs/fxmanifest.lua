game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'


client_scripts { 	
    'config.lua',
	'herb_coords.lua',
    'client.lua',
}
 
server_scripts {
    'config.lua',
	'herb_coords.lua',
    'server.lua',
	'@mysql-async/lib/MySQL.lua',
}

escrow_ignore {
  'config.lua',
  'herb_coords.lua',
}
dependency '/assetpacks'