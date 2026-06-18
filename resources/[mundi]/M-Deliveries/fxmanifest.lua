fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

author 'Mundi'
description 'M-Deliveries - Wagon Deliveries and Smuggling'
version '1.0.1'

dependencies {
    'ox_lib',
    'oxmysql'
}

-- NUI Files
ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/style.css',
    'nui/script.js',
    'nui/notify.css',
    'nui/notify.js',
    'nui/minesweep.js',
    'nui/images/*.png',
    'nui/images/*.gif',
    'nui/sounds/*.wav'
}

shared_scripts {
    '@ox_lib/init.lua',
    'init/locale.lua',              
    'locale/*.lua',                 
    'shared/config.lua',            
    'init/framework.lua'            
}

client_scripts {
    'client/framework_bridge.lua',  
    'client/interaction_bridge.lua', 
    'client/npc_manager.lua',       
    'client/notifications.lua',     
    'client/nui.lua',               
    'client/smuggling.lua',         
    'client/target_zones.lua',      
    'client/package_system.lua',    
    'client/delivery_markers.lua',  
    'client/ambush.lua',            
    'client/ambush_integration.lua', 
    'client/law_alerts.lua',        
    'client/markers_tmarkers.lua'   
}

server_scripts {
    'server/framework_bridge.lua',  
    'shared/config_discord.lua',   
    'server/discord_logger.lua',   
    'server/package_system.lua',   
    'server/server.lua',           
    'server/law_alerts.lua'        
}

escrow_ignore {
    'shared/*.lua',
    'locale/*.lua',
    'sql/*.sql',
    'fxmanifest.lua',
}
dependency '/assetpacks'