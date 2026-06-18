fx_version 'cerulean'
game 'rdr3'

lua54 'yes'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'S.H. Development'
description 'RedM society and business management with ranks, payroll, ledger, billing, stores, storage, blips, advertisements, job crafting, and society Discord webhooks.'
version '1.0.1'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/app.js',
    'crafting_config.lua',
    'locales/*.lua',
    'sql/install.sql'
}

shared_scripts {
    'config.lua',
    'crafting_config.lua',
    'locales/init.lua',
    'locales/en.lua',
    'locales/es.lua',
    'locales/de.lua',
    'locales/fr.lua',
    'shared/utils.lua',
    'shared/locale.lua',
    'shared/framework_bridge.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/database.lua',
    'server/webhooks.lua',
    'server/audit.lua',
    'server/router.lua',
    'server/societies.lua',
    'server/ranks.lua',
    'server/permissions.lua',
    'server/employees.lua',
    'server/ledger.lua',
    'server/billing.lua',
    'server/payroll.lua',
    'server/stores.lua',
    'server/ads.lua',
    'server/crafting.lua',
    'server/blips.lua',
    'server/job_center.lua',
    'server/storage.lua',
    'server/api.lua',
    'server/main.lua'
}

escrow_ignore {
    'config.lua',
    'crafting_config.lua',
    'locales/*.lua'
}

dependency '/assetpacks'
dependency '/assetpacks-redm'