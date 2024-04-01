local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

function CreateJobAnnonce()
    local preset = nil
    if p:getJob() == "lspd" then
        preset = "LSPD"
    elseif p:getJob() == "lsfd" then
        preset = "LSFD"
    elseif p:getJob() == "lssd" then
        preset = "LSSD"
    elseif p:getJob() == "ems" then
        preset = "LSMS"
    elseif p:getJob() == "bcms" then
        preset = "BCMS"
    elseif p:getJob() == "gouv" then
        preset = "GOUV"
    elseif p:getJob() == "justice" then
        preset = "JUSTICE"
    elseif p:getJob() == "usss" then
        preset = "USSS"
    end
    
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'CardNewsSocietyCreate',
        data = {
            name_society = globalData.jobs[p:getJob()].label,
            logo_society = "assets/entrepriseCarre/"..p:getJob()..".jpg",
            preset = preset
        }
    }))
end

RegisterCommand('getjob', function() print(p:getJob()) end, false)
RegisterCommand('getcrew', function() print(p:getCrew()) end, false)

RegisterNUICallback("notificationCreateSociety_callback", function (data, cb)
    print('data', json.encode(data))
    TriggerServerEvent("jobAnnonce:SendInfoNotif", token, data)

    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
end)


AddEventHandler("jobAnnonce:ShowInfoNotif")
RegisterNetEvent("jobAnnonce:ShowInfoNotif", function(data)
    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'CardNewsSocietyShow',
        data = {
            name = data.name_entreprise_notif,
            logo = data.logo_entreprise_notif,
            phone = data.telephone_notif,
            message = data.message_notif,
            typeannonce = data.choiceType_notif,
        }
    }))
    Wait(100)
    SetNuiFocusKeepInput(true)
    SetNuiFocus(true, false)
end)