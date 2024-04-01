fx_version 'cerulean'
games { 'gta5' }

replace_level_meta 'gta5'

data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'
data_file 'GTXD_PARENTING_DATA' 'client/mph4_gtxd.meta'

files {
	'interiorproxies.meta',
    'gta5.meta',
    'water.xml'
}

client_script "client.lua"

client_script {
    "main.lua",
    'client/client.lua',
	'client/mph4_gtxd.meta',
	'client/water.lua',
}

this_is_a_map 'yes'
