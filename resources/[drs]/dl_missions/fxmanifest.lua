fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"
lua54 'yes'

author 'DrShwaggins | DrShwaggîns#8832'
description 'DL-MISSIONS'
version '1.0.2'

shared_scripts {
  'client/dataview.lua',
  'configurations/translations.lua',
  'configurations/config.lua',
  'configurations/task_configurations/*.lua',
  'configurations/task_configurations/**/*.lua',
  'configurations/mission_configurations/*.lua',
  'configurations/mission_configurations/**/*.lua',
} 

client_scripts {
  'configurations/client_framework.lua',
  'client/shady_mission_testtools.lua',
  'client/manager/missionmanager.lua',
  'client/manager/blipmanager.lua',
  'client/manager/vehiclemanager.lua',
  'client/manager/questitemmanager.lua',
  'client/manager/timermanager.lua',
  'client/manager/audiomanager.lua',
  'client/manager/npcmanager.lua',
  'client/eventhandlers.lua',
  'client/taskhandlers/**/*.lua',
  'client/main.lua',
}

server_scripts {
    'configurations/server_framework.lua',
    'server/shady_mission_testtools.lua',
    'server/classes/*.lua',
    'server/vehiclemanager.lua',
    'server/main.lua',
    'server/eventhandlers.lua',
    'server/exports.lua',
    'server/commands.lua',
    'configurations/log_config.lua',
    'server/logging.lua',
}

files {
    'html/index.html',
    'html/js/*.js',
    'html/js/**/*.js',
    'html/*',
    'html/styles/*.css',
    'html/styles/*.*',
    'html/images/**/*.*',
    'html/audios/**/*.*',
}

ui_page 'html/index.html'


escrow_ignore {
  'configurations/*.lua',
  'configurations/**/*.lua',
}


dependencies {
  'oxmysql',
  'ox_lib',
  'rsg-core',
  'rsg-inventory',
  'v-inventory',
}

dependency '/assetpacks'
dependency '/assetpacks-redm'
