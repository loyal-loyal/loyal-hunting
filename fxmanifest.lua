fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name "loyal-hunting"
description "Hunting Script made for QBCore"
author "loyal"
version "1.1.0"

dependencies {
	'/server:5181',
	'/onesync',
}

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}

files {
    'locales/*.json'
}