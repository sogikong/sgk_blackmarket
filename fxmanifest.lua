fx_version 'cerulean'
games { 'gta5' }

author 'SGK_SCRIPT'
description 'Lehký gang shop nebo blackmarket'
version '1.0.0'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts {
    'client.lua',
    'config.lua'
}

server_scripts {
    'server.lua',
    'config.lua'
}