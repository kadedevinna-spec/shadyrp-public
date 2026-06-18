fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
author 'Mundi'
description 'M-Raids — Raids and bank wagon robberies'
version '1.0.0'

lua54 'yes'

dependency 'Mundis-Minigames'

shared_scripts {
  'framework.lua',
  'locale.lua',
  'locales/*.lua',
  'shared/raid_config.lua',
  'shared/bankwagon_config.lua',
  'shared/voice_config.lua',
  'shared/config_discord.lua',
  'shared/config_discord_bw.lua'
}

client_scripts {
  'client/dataview.lua',
  'client/client.lua',
  'client/bankwagon_client.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/bridge.lua',
  'server/discord_logger.lua',
  'server/discord_logger_bw.lua',
  'server/server.lua',
  'server/bankwagon_server.lua'
}

ui_page 'ui/index.html'

files {
  'ui/index.html',
  'ui/app.js',
  'ui/styles.css',
  'ui/icons/*.png',
  'ui/fonts/*.ttf'
}

escrow_ignore {
  'fxmanifest.lua',
  'shared/raid_config.lua',
  'shared/bankwagon_config.lua',
  'shared/voice_config.lua',
  'shared/config_discord.lua',
  'shared/config_discord_bw.lua',
  'locales/*.lua',
  'sql/vorp_items.sql',
  'sql/rsg_items.md'
}

dependency '/assetpacks'
dependency '/assetpacks-redm'