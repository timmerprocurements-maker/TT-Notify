-- Rate Limiting Guard
local RateLimits = {}
local function IsRateLimited(src)
    local now = GetGameTimer()
    RateLimits[src] = RateLimits[src] or { count = 0, reset = now + 1000 }
    if now > RateLimits[src].reset then
        RateLimits[src] = { count = 1, reset = now + 1000 }
        return false
    end
    RateLimits[src].count = RateLimits[src].count + 1
    return RateLimits[src].count > 10
end

AddEventHandler('playerDropped', function()
    local src = source
    RateLimits[src] = nil
end)

local function SendNotification(src, title, desc, notifType, duration, icon)
    if not src or src <= 0 then return end
    if type(title) == 'table' then
        TriggerClientEvent('tt_notify:client:SendAlert', src, title.title, title.description or title.message or title.msg, title.type or title.notifyType, title.duration)
    else
        TriggerClientEvent('tt_notify:client:SendAlert', src, title, desc, notifType, duration)
    end
end

exports('Notify', SendNotification)
exports('SendAlert', SendNotification)
exports('SendNotification', SendNotification)

RegisterNetEvent('tt_notify:server:SendAlert', function(title, desc, notifType, duration, icon)
    local src = source
    if not src or src <= 0 or IsRateLimited(src) then return end
    SendNotification(src, title, desc, notifType, duration, icon)
end)

RegisterNetEvent('ag_notify:server:SendAlert', function(title, desc, notifType, duration, icon)
    local src = source
    if not src or src <= 0 or IsRateLimited(src) then return end
    SendNotification(src, title, desc, notifType, duration, icon)
end)
