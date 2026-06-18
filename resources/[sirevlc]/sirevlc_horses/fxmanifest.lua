game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'
 
client_scripts {
  'CONFIG/*.lua',
  'CLIENT/*.lua',
}

server_scripts {
  'CONFIG/*.lua',
  'SERVER/server.lua',
  'SERVER/REGISTERED_ITEMS.lua',
}

escrow_ignore {
  'CONFIG/*.lua',
  'SERVER/REGISTERED_ITEMS.lua',
}
dependency '/assetpacks'
dependency '/assetpacks-redm'