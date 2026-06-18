fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
version '1.3.0'
shared_script {
    'config/*.lua',

}
client_scripts {
	'@ox_lib/init.lua',
	'dataview.lua',
    'client/*.lua',
	'config/jobs/*.lua'
}


server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/adapters/*.lua',
	'server/function.lua',
	'config/jobs/*.lua',
    'server/*.lua'
}



escrow_ignore {
    'config/*.lua',
    'config/jobs/*.lua',
    'server/adapters/*.lua',
    'client/client.lua',
	'client/function.lua',
}

files {
	'ui/img/*',
	'ui/img/Poster_bg/*',
	'ui/img/Poster_art/*',
	'ui/*.js',
	'ui/*.json',
	'ui/css/*.css',
	'ui/index.html',
	'ui/*.ttf',
	'ui/*.otf'
}

ui_page 'ui/index.html'

lua54 'yes'
dependency '/assetpacks'