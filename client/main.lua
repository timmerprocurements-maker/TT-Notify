local RegisterNetEvent = RegisterNetEvent
local SendNUIMessage = SendNUIMessage

local function GetDefaultTitle(notifyType)
    local t = string.lower(tostring(notifyType or 'inform'))
    if t == 'success' then return 'SUCCESS'
    elseif t == 'error' then return 'ERROR'
    elseif t == 'warning' then return 'WARNING'
    elseif t == 'police' or t == 'dispatch' then return 'DISPATCH'
    elseif t == 'bank' or t == 'banking' then return 'BANKING'
    elseif t == 'admin' then return 'ADMINISTRATION'
    else return 'INFORMATION'
    end
end

local function SendAlert(title, description, notifyType, duration)
    -- Handle table argument format
    if type(title) == 'table' then
        return SendAlert(
            title.title or title.header,
            title.description or title.message or title.msg,
            title.type or title.notifyType,
            title.duration
        )
    end

    -- Handle shorthand or single/two argument forms
    local finalTitle = title
    local finalDesc = description
    local finalType = notifyType or 'inform'
    local finalDuration = tonumber(duration) or 4500

    if not description and title then
        finalTitle = GetDefaultTitle(finalType)
        finalDesc = tostring(title)
    elseif title and (title == 'Notification' or title == '') then
        finalTitle = GetDefaultTitle(finalType)
    end

    SendNUIMessage({
        action = 'notify',
        title = finalTitle,
        description = finalDesc,
        type = finalType,
        duration = finalDuration
    })
end

exports('Notify', SendAlert)
exports('Alert', SendAlert)
exports('SendAlert', SendAlert)

RegisterNetEvent('tt_notify:client:SendAlert', function(title, description, notifyType, duration)
    SendAlert(title, description, notifyType, duration)
end)

RegisterNetEvent('ag_notify:client:SendAlert', function(title, description, notifyType, duration)
    SendAlert(title, description, notifyType, duration)
end)

-- Backward-Compatibility Event Adapters
RegisterNetEvent('ox_lib:notify', function(data)
    SendAlert(data)
end)

RegisterNetEvent('QBCore:Notify', function(text, notifyType, length)
    local nType = notifyType or 'inform'
    SendAlert(GetDefaultTitle(nType), text, nType, length or 4500)
end)
