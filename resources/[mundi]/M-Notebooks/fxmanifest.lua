fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'
lua54 'yes'

author 'Mundi'
description 'M-Notebooks with Pinning, Drawing, Animations & many more Customizations'
version '1.0.4'

dependencies {
    'ox_lib',
    'oxmysql',
}

-- ox_target is OPTIONAL — used for pinned note interaction when Config.Pinning.useOxTarget = true
-- If disabled, native RDR2 prompts are used instead

-- NUI Files
ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/style.css',
    'nui/script.js',
    'nui/images/*.png',
    'nui/images/*.jpg',
    'nui/images/*.gif',
    'nui/sound/*.wav',
    'nui/sound/*.ogg',
    'nui/sound/*.mp3'
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'locale.lua',
    'notifications.lua'
}

client_scripts {
    'client/framework.lua',
    'client/nui.lua',
    'client/main.lua',
    'client/pinned.lua',
    'client/telegrams_compat.lua',  -- M-Telegrams address book tab (optional, auto-disabled if M-Telegrams not running)
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/framework.lua',
    'server/notebook_meta_fix.lua',
    'server/main.lua'
}

escrow_ignore {
    'shared/config.lua',
    'locale.lua',
    'notifications.lua',
    'fxmanifest.lua',
    'README.md',
    'sql/*'
}
dependency '/assetpacks'
dependency '/assetpacks-redm'