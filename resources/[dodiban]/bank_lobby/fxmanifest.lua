fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
    'config.lua',
    'client.lua',
    'dataview.lua',
    
}

server_scripts {
    'config.lua',
    "@mysql-async/lib/MySQL.lua",
    'server.lua',
}

ui_page 'html/index.html' -- Atualizado para apontar para o arquivo HTML correto

files {
    'html/index.html',        -- Arquivo principal da interface
    'html/styles.css',        -- Estilos principais do lobby
    'html/animations.css',    -- Animações separadas
    'html/notifications.css', -- Estilos das notificações
    'html/profile.css',       -- Estilos do modal de perfil
    'html/member-details.css', -- Estilos do modal de detalhes do membro
    'html/scripts.js',        -- JavaScript da interface
    'html/images/*.png',      -- Imagens das notificações
}

escrow_ignore {
    'config.lua',
    'server.lua',
}

lua54 'yes'
dependency '/assetpacks'