fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

server_script {
	'server.lua',
	'config.lua'
}
 
client_script {
	'dataview.lua',
	'client.lua',
	'config.lua'
}

escrow_ignore {
    'config.lua',
	'client.lua',
	'server.lua',
	'dataview.lua',
  }

lua54 'yes'
dependency '/assetpacks'