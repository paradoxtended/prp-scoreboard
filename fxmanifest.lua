fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
name 'prp_admin'
game 'gta5'
author 'Paradoxtended'
version '1.0.0'
repository 'https://github.com/paradoxtended/prp_admin_v2'
description 'Advanced admin menu for FiveM servers'

dependencies {
    'ox_lib'
}

shared_script '@ox_lib/init.lua'

ui_page 'web/dist/index.html'

client_script 'cl-main.lua'
server_script 'sv-main.lua'

files {
    'web/dist/**/*'
}