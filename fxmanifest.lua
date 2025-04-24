name 'SW-Consumables'
author 'SH4UN'
version '2.0'
description 'Food/Drink Consumables Script'
fx_version 'cerulean'
game 'gta5'

client_scripts {
	'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

shared_scripts {
    'config.lua',
	'locales/*.lua',
	'@ox_lib/init.lua'
}

lua54 'yes'

escrow_ignore {
	'config.lua',
	'README.md',
	'locales/*.lua'
}

dependencies {
	'sw_lib'
}