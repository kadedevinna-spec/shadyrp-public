rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
fx_version 'cerulean'
game 'rdr3'
lua54 'yes'

author 'Dietrich Development'
version '2.2.3'

description 'Dietrich Development Gamemaster'


client_scripts {
    'tools/dataview.lua',
    'core/client/data/index.lua',
    -- Core client modules
    'core/client/keys.lua',
    'core/client/controls.lua',
    'core/client/state.lua',
    'core/client/camera.lua',
    'core/client/selection.lua',
    'core/client/geom.lua',
    'core/client/commands.lua',
    'core/client/context_menu.lua',
    'core/client/infrared_vision.lua',
    'core/client/draw.lua',
    'core/client/radial_menu.lua',
    'core/client/groups.lua',
    'core/client/nui.lua',
    'core/client/weather_ui.lua',
    'core/client/input.lua',
    -- Core DLC feature wiring
    'core/client/dlc_client.lua',
    -- DLC: objects
    'dlc/objects/client/stream.lua',
    'dlc/objects/client/placement.lua',
    -- DLC: impersonate
    'dlc/impersonate/client/impersonate.lua',
    -- DLC: vehicles
    'dlc/vehicles/client/vehicles.lua',
    -- DLC: elements
    'dlc/elements/client/elements.lua',
    -- DLC: admin (player kill/heal/message, gated by gm.admin)
    'dlc/admin/client/admin.lua',
    -- Exports (public API)
    'core/client/exports.lua',
    -- Entrypoint
    'core/client/main.lua',
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    -- Core server modules
    "core/server/crypto.lua",
    "core/server/dlc_manifest.lua",
    "core/server/dlc_auth.lua",
    "core/server/feature_registry.lua",
    "core/server/server_init.lua",
    "core/server/licenceCheck.lua",
    "core/server/server.lua",
    -- DLC: objects
    "dlc/objects/server/proxy.lua",
    -- DLC: elements
    "dlc/elements/server/elements.lua",
    -- DLC: admin
    "dlc/admin/server/admin.lua",
}

shared_scripts {
	-- Runtime first so game/framework shims can guard on it
	'shared/runtime.lua',

	-- Bridge core and shims (preload to avoid runtime file reads)
	'bridge/core.lua',
	'bridge/entities.lua',
	'bridge/state.lua',
	'bridge/game/redm.lua',
	'bridge/framework/*.lua',

	-- Bridge entrypoint last to wire everything together
	'bridge/index.lua',

	-- Config:
    'config/language.lua',
    'config/config.lua',
    'config/hook.lua',
    'config/data_items_generated.lua',
    'config/data.lua',
    'config/contextMenus.lua',
    'config/tutorial.lua',
}

ui_page 'ui/dist/index.html'

files {
    'ui/dist/index.html',
    'ui/dist/assets/*',
    'ui/dist/images/*',
    'ui/dist/images/items/*',
    'ui/dist/images/animations/redm/*',
    'ui/dist/images/animations/fivem/*',
    'bridge/**/*.lua',
    'bridge/*.lua',
    'core/client/data/**/*.lua',
    'dlc/**/*.lua',
    'shared/override.lua',
}

escrow_ignore {
    'config/*.lua',
    'tools/*.lua',
    'ui/dist/*',
    'ui/dist/**/*',
    'bridge/framework/*.lua',
    'core/client/data/**/*.lua',
}

dependency '/assetpacks'