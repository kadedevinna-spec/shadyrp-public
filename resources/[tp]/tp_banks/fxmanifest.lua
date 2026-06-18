fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Nosmakos'
description 'Titans Products - Advanced Banks'
version '1.1.5'

ui_page 'html/index.html'

shared_scripts { 'config.lua', 'locales.lua' }
server_scripts { 'server/*.lua' }
client_scripts { 'client/*.lua' }

files { 'html/**/*' }

dependencies { 'tp_libs', 'tp_inputs', 'tp_notify' }
escrow_ignore { 'config.lua', 'locales.lua', 'client/tp-client_doorhashes.lua', 'client/tp-client_escrow_ignore.lua', 'server/tp-server_escrow_ignore.lua' }

lua54 'yes'
dependency '/assetpacks'
dependency '/assetpacks-redm'