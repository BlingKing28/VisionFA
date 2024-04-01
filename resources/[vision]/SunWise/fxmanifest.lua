fx_version "bodacious"
game 'gta5'
author 'Flozii'
description "SunWise Anticheat developed by Flozii#0502"

lua54 "yes"

ui_page 'client/index.html'

files {
	'client/index.html',
	'client/js/*.js'
}

client_scripts {
	"config.lua",
    "configlists.lua",
	"client/ac.lua",
	--"loader/loader_c.lua",
	"client/screen.js",
	"client/executors.lua",
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    "config.lua",
    "config_s.lua",
	--"loader/loader_s.lua",
    "configlists.lua",
	"server/ban_s.lua",
	"server/ac_s.lua",
	"server/executors_s.lua",
	"server/trustFactor.lua",
	"server/screen.js",
	"server/suspect_list.lua",
}

shared_script {
    "config_sh.lua",
}

disable_lazy_natives 'yes'

escrow_ignore {
	"client/index.html",
	"client/js/*.js",
	"client/*.js",
	"server/*.js",
	"config.lua",
	"config_sh.lua",
	"config_s.lua",
	"configlists.lua",
	"*.json",
	"*.sql",
}