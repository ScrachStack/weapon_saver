-- for support https://syncstudio.org/discord 
fx_version 'cerulean'
games {  'gta5' }
lua54 'yes'
author 'ScratchStack (Sync Studio)'
description 'Saves your players’ weapons when they log out and gives them back on login sync studio'
version '1.0.0'
name 'weapon_saver'
repository 'https://syncstudio.org/store/saveweapon'

client_scripts {
    'client/*',
}

server_scripts {
    'server/*',
    
}

shared_scripts {
  'config.lua',
}
