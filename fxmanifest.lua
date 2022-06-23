fx_version 'adamant'
game 'gta5'
version '1.1.6'


client_scripts {
    "config.lua",
    "cl_taxi.lua",
    "pmenu.lua",
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "sv_taxi.lua",
    "config.lua",
}