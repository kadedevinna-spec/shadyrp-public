fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
description 'Fixitfy Trade System'
author "Fixitfy Development"
version "1.5"

shared_scripts {
    "framework/*.lua",
    "config.lua"
}

client_scripts {
    "c/c.lua",
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

escrow_ignore {
    'config.lua',
    's/opensource.lua',
    'framework/*.lua'
}


lua54 'yes'
dependency '/assetpacks'