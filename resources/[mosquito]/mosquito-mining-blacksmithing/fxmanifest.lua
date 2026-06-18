fx_version 'adamant'
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Mosquito'
description 'A mining & blacksmithing script.'
version '1.3.0'

lua54 'yes'

dependency 'objectloader'
dependency 'rsg-core'
dependency 'rsg-inventory'
dependency 'vorp_core'
dependency 'vorp_inventory'

client_scripts {
    'debug.lua',
    'common/dataview.lua',
    'common/notify.lua',
    '@PolyZone/client.lua',
    '@PolyZone/ComboZone.lua',
    'config/*.lua',
    'client/checker_func.lua',
    'client/client.lua',
    'client/maintenance.lua',
    'client/crusher.lua',
}

server_scripts {
    'debug.lua',
    'config/*.lua',
    'server/notify.lua',
    'server/server.lua',
    'vorp_export.lua',
}

files {
    'rmv_props_bw_blksmth.xml',
    'rockcrusher.xml',
    'stream/*.ytyp',
    'imgs/*.png',
    'item_imgs/*.png',
}

objectloader_maps {
    'rmv_props_bw_blksmth.xml',
    'rockcrusher.xml',
}

escrow_ignore {
    'debug.lua',
    'vorp_export.lua',
    'config/*.lua',
    'dataview.lua',
    'imgs/*.png',
    'items.sql',
}

data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'

dependency '/assetpacks'
dependency '/assetpacks-redm'
