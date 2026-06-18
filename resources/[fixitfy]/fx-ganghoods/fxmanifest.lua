fx_version "adamant"
game "rdr3"
this_is_a_map "yes"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

author "FIXITFY | BK"
description "Gang Hoods"
version '1.1'

shared_scripts {
    "framework/*.lua",
    "config.lua",
}

client_scripts {
    "c/*.lua",
}

server_scripts {
    "s/*.lua",
    "versionchecker.lua"
}

files {
    'timecycle.xml',
}

data_file "TIMECYCLEMOD_FILE" "timecycle.xml"

escrow_ignore {
    'framework/*.lua',
    'versionchecker.lua',
    "config.lua"
}

lua54 'yes'
dependency '/assetpacks'
dependency '/assetpacks-redm'