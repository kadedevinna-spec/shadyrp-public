fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_script 'config.lua'

client_scripts {
    'ui.lua',
    'client.lua',
    'dataview.lua',
    
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'server.lua',
}

ui_page 'html/index.html' -- Atualizado para apontar para o arquivo HTML correto

files {
    'html/index.html', -- Arquivo principal da interface
    'html/*.css',      -- Arquivos de estilo (se você usar algum)
    'html/images/*',   -- Pastas de imagens, se forem usadas na interface
    'html/*.js',
    'html/*.svg',
    'html/*.ttf',
}

escrow_ignore {
    'config.lua',
    'server.lua',
}

lua54 'yes'
dependency '/assetpacks'