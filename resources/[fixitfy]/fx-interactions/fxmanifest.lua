fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
author "Fixitfy"
description 'Fixitfy Interactions for Chairs and Benches'
version "1.8"

shared_scripts {
    "framework/frameworks.lua",
    "config.lua",
    "config_animations.lua",
    "config_props.lua",
}

client_scripts {
    "c/functions.lua",
    "c/c.lua",
}
server_scripts {
    "s/*.lua",
    "versionchecker.lua"
}

ui_page 'ui/index.html'

files {
    "favorites.json",
    'ui/**/*',
}


escrow_ignore {
    'config_animations.lua',
    "config_props.lua",
    'config.lua',
    "favorites.json",
    'versionchecker.lua',
    'framework/*.lua',
}

lua54 'yes'

dependency '/assetpacks'
dependency '/assetpacks-redm'