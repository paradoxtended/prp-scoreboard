fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
name 'prp_admin'
game 'gta5'
author 'Paradoxtended'
version '1.0.1'
repository 'https://github.com/paradoxtended/prp_admin_v2'
description 'Advanced admin menu for FiveM servers'

dependencies {
    'ox_lib',
    'prp_lib'
}

shared_scripts {
    '@ox_lib/init.lua',
    '@prp_lib/init.lua'
}

ui_page 'web/dist/index.html'

client_script 'init.lua'
server_script 'init.lua'

files {
    'config.json',
    'web/dist/index.html',
    'web/dist/**/*',
    'client.lua',
    'server.lua'
}