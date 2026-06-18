fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

name 'rco-dialogs'
description 'Advanced Dialogs'
author 'rust1co'
version '1.0.0'

dependencies {
    'ox_lib'
}

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
    'client/*.lua'
}

lua54 'yes'

ui_page 'web/build/index.html'

files {
    'web/build/index.html', 
    'web/build/**/*'
}
dependency '/assetpacks'