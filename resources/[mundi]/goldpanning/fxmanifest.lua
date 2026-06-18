fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'
author 'Mundi'
version '1.0.5'
description 'Gold Panning - Interactive gold panning minigame with cradle system (VORP & RSG Compatible)'

-- Shared scripts (loaded first)
shared_scripts {
    'config.lua',
    'locale.lua',
    'bridge/shared.lua'
}

-- Client scripts
client_scripts {
    'progressbar.lua',
    'bridge/client.lua',
    'client/client.lua'
}

-- Server scripts
server_scripts {
    'bridge/server.lua',
    'server/server.lua'
}

ui_page 'html/index.html'
files {
    'html/index.html',
    'html/js/script.js',
    'html/css/style.css',
    -- Minigame images
    'html/img/background.png',
    'html/img/full.png',
    'html/img/gold_flake.png',
    'html/img/gold_nugget.png',
    'html/img/partial1.png',
    'html/img/partial2.png',
    'html/img/partial3.png',
    'html/img/partial4.png',
    'html/img/partial5.png',
    'html/img/partial6.png',
    -- Progress bar background
    'html/img/progress_bg.png',
    -- Item icons for inventory
    'html/img/items/goldpan.png',
    'html/img/items/gold_flakes.png',
    'html/img/items/gold_nugget.png',
    'html/img/items/mud_bucket.png',
    'html/img/items/emptybucket.png',
    'html/img/items/fullbucket.png',
    'html/img/items/p_goldcradlestand01x.png',
    -- Audio
    'html/audio/collect.mp3',
    'html/audio/shake.mp3'
}

-- NO HARD DEPENDENCIES - Script auto-detects framework
-- Supports: vorp_core + vorp_inventory OR rsg-core + rsg-inventory

-- Escrow configuration for Tebex
escrow_ignore {
    'config.lua',
    'config.example.lua',
    'locale.lua',
    'progressbar.lua',
    'README.md',
    'sql/*'
}

dependency '/assetpacks'