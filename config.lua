Config = {}

-- Notification Display Settings
Config.DefaultDuration = 5000 -- 5 seconds default
Config.Position = "top-right" -- top-right | top-center | top-left | bottom-right | bottom-left
Config.MaxVisible = 5
Config.SoundEnabled = true

-- Custom Sound Profile Frequencies (Web Audio API)
Config.Types = {
    ['success'] = {
        icon = 'fa-solid fa-circle-check',
        color = '#10b981',
        title = 'SUCCESS'
    },
    ['error'] = {
        icon = 'fa-solid fa-circle-xmark',
        color = '#ef4444',
        title = 'ERROR'
    },
    ['warning'] = {
        icon = 'fa-solid fa-triangle-exclamation',
        color = '#f59e0b',
        title = 'WARNING'
    },
    ['inform'] = {
        icon = 'fa-solid fa-circle-info',
        color = '#06b6d4',
        title = 'INFO'
    },
    ['level_up'] = {
        icon = 'fa-solid fa-star',
        color = '#fbbf24',
        title = 'LEVEL UP'
    }
}
