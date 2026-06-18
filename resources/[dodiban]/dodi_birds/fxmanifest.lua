fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
    'config.lua',
    'notify.lua',
    'dataview.lua',
    'functions.lua',
    'events.lua',
    'client.lua'
}

server_scripts {
    'config.lua',
    "@mysql-async/lib/MySQL.lua",
    'server.lua'
}

ui_page 'html/html.html'

files {
	'html/*',
    'html/images/*',
    'html/sounds/*'
}

escrow_ignore {
	'config.lua',
	'server.lua'
}

lua54 'yes'

dependency '/assetpacks'