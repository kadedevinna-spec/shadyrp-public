fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
description 'Fixitfy Premimum Hud System'
author "Fixitfy Development"
version "3.0.1"

shared_scripts {
    "framework/*.lua",
    "config.lua",
    "consumables.lua",
    -- '@ox_lib/init.lua',
}

client_scripts {
    "c/*.lua",
}
server_scripts {
    "s/s.lua",
    "s/opensource.lua",
    "versionchecker.lua"
}

ui_page 'ui/index.html'

files {
    'ui/**/*',
}

dependencies {
    'oxmysql',
}

escrow_ignore {
    'config.lua',
    'consumables.lua',
    'c/opensource.lua',
    's/opensource.lua',
    'framework/*.lua',
    "versionchecker.lua",
}

lua54 'yes'
dependency '/assetpacks'
dependency '/assetpacks-redm'