fx_version 'adamant'
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'

description 'General Store (modular) for RSG-Core'
version '0.1.1'

dependencies {
    'oxmysql',
    'rsg-core',
    'rsg-inventory',
}

client_scripts {
    'config.lua',
    'config_consumables.lua',
    'client_drawtext3d.lua',
    'client_cam_display.lua',
    'dataview.lua',
    'client.lua',
    'client_shelf.lua',
    'client_consume.lua',
    'client_robbery.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'config_consumables.lua',
    'server_stock.lua',
    'server_owned.lua',
    'server.lua',
    'server_consume.lua',
    'server_robbery.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/*.css',
    'html/*.js',
    'html/images/*',
}

escrow_ignore {
    'fxmanifest.lua',
    'config.lua',
    'config_consumables.lua',
    'README.md',
    'itens_rsg.txt',
}
