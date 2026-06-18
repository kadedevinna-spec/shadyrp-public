fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_script 'config.lua'

client_scripts {
    'config.lua',
    'dataview.lua',
    'client_dialgame.lua',
    'client_rounds.lua',
    'client_generator.lua',
    'client_hostages.lua',
    'client_hostage_functions.lua',
    'client_supply_wagon.lua',
    'client_timertorobbery.lua',
    'client_bankrobbery.lua',
    'client_doorlocks.lua',
    'client_torch.lua',
    'client_torch_tool.lua',
    'client_notes.lua',
    'client_vaults.lua',
    
}

server_scripts {
    'config.lua',
    "@mysql-async/lib/MySQL.lua",
    'server.lua',
    'server_doorlocks.lua',
    'server_usableitems.lua',
    'server_vaults.lua'
}

ui_page 'html/index.html' -- Atualizado para apontar para o arquivo HTML correto

files {
    'html/index.html', -- Arquivo principal da interface
    'html/images/*',
    'html/*.css',      -- Arquivos de estilo
    'html/*.js',       -- Scripts JavaScript
    'html/audio/*.mp3', -- Arquivos de áudio (incluindo generator_loop.mp3)
	'html/sounds/*.mp3',
    'html/safe_dial.glb', -- Modelo 3D do dial
}

escrow_ignore {
    'config.lua',
    'server_usableitems.lua',
    'server.lua',
}

lua54 'yes'
dependency '/assetpacks'