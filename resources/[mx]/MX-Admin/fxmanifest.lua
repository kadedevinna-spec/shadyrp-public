fx_version 'cerulean'
lua54 'yes'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

description 'rsg-adminmenu'
version '2.1.0'

ui_page 'html/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'config_discord_staff.lua',
    'shared/admin_translations.lua',
    'shared/framework.lua',
}

client_scripts {
    'client/*.lua',
}

escrow_ignore {
    'config.lua',
    'config_discord_staff.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/geoip.lua',
    'server/discord_staff.lua',
    'server/permission_matrix.lua',
    'server/server.lua',
    'server/server_bans.lua',
    'server/server_finances.lua',
    'server/server_reports.lua',
    'server/server_dashboard.lua',
    'server/server_adminchat.lua',
    'server/server_teleports.lua',
    'server/server_bloodmoon.lua',
    'server/server_announce.lua',
}

files {
    'locales/*.json',
    'translations/*.json',
    'html/index.html',
    'html/style.css',
    'html/app.js',
    'html/vendor/**/*',
    'html/teleports/**/*',
    'html/teleports/*.png',
    'html/teleports/*.jpg',
    'html/livemap/**/*',
    'html/img/**/*',
}

dependencies {
    'ox_lib',
}

dependency '/assetpacks'
dependency '/assetpacks-redm'