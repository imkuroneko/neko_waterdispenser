fx_version  'cerulean'
game        'gta5'
lua54       'yes'
-- ===========================================================
description 'Complemento para utilizar dispensadores de agua'
author      'KuroNeko'
-- ===========================================================
version     '1.1.0'

-- ===========================================================
shared_scripts { '@ox_lib/init.lua', 'config.lua' }
server_scripts { 'server.lua' }
client_scripts { 'client.lua' }
files          { 'locales/es.json' }
dependencies   { 'qb-target' }