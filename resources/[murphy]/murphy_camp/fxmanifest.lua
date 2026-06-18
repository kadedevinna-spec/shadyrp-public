fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
version "2.10.0"
server_script {
	'@oxmysql/lib/MySQL.lua',
	'shared/*.lua',
	'shared/interaction/*.lua',
	'server/adapters/*.lua',
	'server/*.lua',
}
 
client_script {
	'shared/*.lua',
	'client/*.lua',
	'shared/interaction/*.lua',
}

escrow_ignore {
	'client/*.lua',
	'shared/*.lua',
	'shared/interaction/*.lua',
	'server/adapters/*.lua',
	'server/*.lua',
}
lua54 "yes"
dependency '/assetpacks'
dependency '/assetpacks-redm'