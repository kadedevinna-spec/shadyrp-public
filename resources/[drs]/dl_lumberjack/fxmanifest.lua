fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"

author 'DrShwaggins | DrShwaggîns#8832'
description 'dl-lumberjack'

lua54 'yes'

client_scripts {
	'@uiprompt/uiprompt.lua',
	'@ox_lib/init.lua',
	'client/prompts.lua',
	'client/client.lua',
	'client/propspawning.lua',
}

shared_scripts {
	'config.lua',
	'shared/translation.lua',
	'client/dataview.lua',
	'client/functions.lua',
	'client/stations.lua',
}

server_scripts {
	'shared/json.lua',
	'server/server.lua',
	'server/callbacks.lua',
}

escrow_ignore {
  'config.lua',
	'shared/json.lua',
	'shared/translation.lua',
	'logstorages.json',
	'sql.sql',
}

dependency '/assetpacks'
dependency '/assetpacks-redm'