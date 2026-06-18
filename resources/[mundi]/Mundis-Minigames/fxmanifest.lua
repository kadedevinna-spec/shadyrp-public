fx_version 'cerulean'
game 'rdr3'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Mundi'
description 'Mundis Minigames - Always loads first'
version '1.0.0'

lua54 'yes'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/img/*.png',
    'html/sounds/*.wav',
    'html/sounds/*.mp3',
    'html/sounds/*.ogg'
}

shared_scripts {
    'config.lua'
}

client_script 'client.lua'
server_script 'server.lua'

exports {
    'StartLock',
    'StartWireCutting',
    'StartLockpick',
    'StopLockpick',
    'StartAlarm',
    'StopAlarm',
    'PrepareAlarm'
}

escrow_ignore {
    'fxmanifest.lua',
    'config.lua'
}
dependency '/assetpacks'
dependency '/assetpacks-redm'