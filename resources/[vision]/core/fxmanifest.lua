fx_version 'adamant'
game 'gta5'
lua54 "yes"

loadscreen_manual_shutdown "yes"

shared_script {
    'config/items_use.lua',
    'shared/**/*',
    "server/addon/*.json"
}

escrow_ignore {
    "client/**/*.mp3",
    "client/**/*.png",
    "client/**/*.ttf",
    "client/**/*.otf",
    "client/loadscreen/*.html",
    "client/loadscreen/*.css",
    "client/loadscreen/*.js",
    "client/loadscreen/*.webm",
    "config/*.json",
    "config/*.txt",
    "stream/**/*.gfx",
    "stream/*.gfx",
    "stream/*.ydr",
    "stream/*.ytd",
    "server/**/*.lua"
}

files {
    'client/webapp/*.html',
    -- 'client/webapp/js/*.js',
    -- 'client/webapp/img/*.png',
    'client/webapp/assets/radio/off.ogg',
    'client/webapp/assets/radio/on.ogg',

    -- 'client/webapp/css/*.css',
    'client/webapp/**/*',
    "client/**/*.ttf",
    'client/loadscreen/*',

    -- 'client/addon/dev/anim/animations.txt',
    '@VisionASSETS/**/*.webp',
}

ui_page 'client/webapp/index.html'
loadscreen 'client/loadscreen/index.html'

client_scripts {
    --'@GolfActivity/**/*.lua',
    'client/security/*.lua',
    "client/modules/handler/module_handler.lua",
    "client/modules/module/native_ui.lua",
    "client/modules/module/*.lua",
    'client/RageUI/RMenu.lua',
    'client/RageUI/menu/RageUI.lua',
    'client/RageUI/menu/Menu.lua',
    'client/RageUI/menu/MenuController.lua',
    'client/RageUI/components/*.lua',
    'client/RageUI/menu/elements/*.lua',
    'client/RageUI/menu/items/*.lua',
    'client/RageUI/menu/panels/*.lua',
    'client/RageUI/menu/windows/*.lua',

    -- Config
    'config/coffreveh.lua',
    'config/3dme.lua',
    'config/items.lua',
    'config/jobs.lua',
    'config/realisticveh.lua',
    'config/staff.lua',
    -- 'config/ems.lua',
    'config/animation.lua',
    'config/blips.lua',
    'config/dev.lua',
    'config/vehicle_shop.lua',
    'config/garage.lua',
    'config/cloths_animation.lua',
    'config/default_cloths_value.lua',
    'config/weapons.lua',
    'config/doors.lua',
    -- 'config/usms.lua',
    -- 'config/police.lua',
    'config/weazel.lua',
    -- 'config/market.lua',
    'config/property.lua',
    'config/tattoos.lua',
    'config/superette_holdup.lua',
    'config/robbery_market.lua',
    -- 'config/licences.lua',
    'config/house_heist_data.lua',
    'config/vangelico_heist_config.lua',
    'config/config_trailer.lua',
    -- Client



    'client/class/*.lua',
    'client/utils/*.lua',
    'client/RubyUI/*.lua',

    -- 'client/lib/**/**/*.lua',

    'client/data/*.lua',
    'client/handler/*.lua',
    'client/function/*.lua',
    'client/command/*.lua',
    'client/addon/**/**/*.lua',
    'client/admin/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config/**/*.lua',
    'config/3dme.lua',
    'config/jobs.lua',
    'config/coffreveh.lua',
    'config/logs.lua',

    'server/utils/utils.lua',

    'server/class/**/*.lua',
    'server/handler/**/*.lua',
    'server/admin/*.lua',
    'server/security/**/*.lua',
    'server/addon/**/*.lua',
    'server/command/**/*.lua',
    'server/crew/**/*.lua',

    'server/data/**/*.lua',
    'server/utils/**/*.lua',
}

exports {
    'TriggerServerCallback',
    'cleanPlayer',
    'GROSNIBARD',
    'GetMoneyPlayer',
    'getMoneyPhone',
    'GetJobPlayerData',
    'getId',
    'GetPlayer',
    'AddMoneyToSociety',
    'GetPlayerPerm',
    'GiveItemToPlayer',
    'RemoveItemToPlayer',
    'DoesPlayerHaveItemCount',
    'getPermission',
    'GetPlayerIdbdd',
    'GetPlayerFullname',
}
