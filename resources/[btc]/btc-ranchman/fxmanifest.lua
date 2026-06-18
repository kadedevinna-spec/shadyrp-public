fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

description 'btc-ranchman 2'
version '1.0.5d'

shared_scripts {
    'config/config.lua',
    'config/config_ranchs.lua',
    'config/config_animals.lua',
    'config/config_new_animals.lua',
    'config/config_slaughterhouse.lua',
    'config/config_raids.lua',
    'shared/locale.lua',
    'shared/functions.lua',
    'shared/open_functions.lua'
}

client_scripts {
    'client/client_menu.lua',
    'client/client_functions.lua',
    'client/client_ranch_chores.lua',
    'client/client_animal_manager.lua',
    'client/client_area.lua',
    'client/client_props.lua',
    'client/client_showroom.lua',
    'client/client_horse.lua',
    'client/client_slaughterhouse.lua',
    'client/client_raids.lua',
    'client/client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server_init_functions.lua',
    'server/server_functions.lua',
    'server/server.lua',
    'server/server_shop.lua',
    'server/server_net_events.lua',
    'server/server_loops.lua',
    'server/server_raids.lua',
    'server/server_exports.lua',
    'server/server_chore.lua',
    'server/server_callbacks.lua',
    'server/server_slaughterhouse.lua',
    'server/server_animal_manager.lua',
    'server/server_horse.lua',
    'server/taxes.lua',
    'server/versionchecker.lua',
    'server/webhook.lua'
}

ui_page 'html/ui.html'

escrow_ignore {
    'config/config.lua',
    'config/config_ranchs.lua',
    'config/config_animals.lua',
    'config/config_new_animals.lua',
    'config/config_slaughterhouse.lua',
    'config/config_raids.lua',
    'shared/locale.lua',
    'shared/functions.lua',
    'shared/open_functions.lua',
    'shared/locale.lua',
    'server/taxes.lua',
}

files {
    'html/ui.html',
    'html/style.css',
    'html/script.js',
    'html/shop.js',
    'html/locale.js',
    'html/js/vue.global.prod.js',
    'images/*.png',
    'html/fonts/*.ttf',
    'html/layoutNUI/*.png'

}


dependencies {
    'btc-core',
}

lua54 'yes'

dependency '/assetpacks'
dependency '/assetpacks-redm'