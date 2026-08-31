fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'tt_notify'
author 'Timmer Technologies'
description 'Timmer Technologies Dynamic Haptic & Audio Web Notification Bus'
version '2.0.0'

ui_page 'html/index.html'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}


escrow_ignore {
    'config.lua'
}

files {
    'html/webfonts/**',
    'html/webfonts/*',
    'html/vendor/**',
    'html/vendor/*',
    'html/index.html',
    'html/style.css',
    'html/script.js'
}
