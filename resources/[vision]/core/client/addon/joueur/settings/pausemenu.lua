local StatuMenu = false
local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

Keys.Register("ESCAPE", "ESCAPE", "Ouvrir le menu principal", function()
    if not StatuMenu and not IsPauseMenuActive() then
        closeUI()
        Wait(200)
        StatuMenu = true
        forceHideRadar()
        TriggerScreenblurFadeIn(1000)
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = 'openWebview',
            name = 'MenuEscape',
        })
    end
end)

RegisterNUICallback("focusOut", function(data)
    if StatuMenu then
       -- print("focus out")
        StatuMenu = false
        TriggerScreenblurFadeOut(1000)
        SetNuiFocus(false, false)
        closeUI()
    end
end)


RegisterNUICallback("openMap", function(data)
    TriggerScreenblurFadeOut(1000)
    SetNuiFocus(false, false)
    closeUI()
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), 0, -1)
    --Wait(100)
    --PauseMenuceptionGoDeeper(0)
    --while true do
    --    Wait(10)
    --    if IsControlJustPressed(0, 177) then
    --        SetFrontendActive(0)
    --        break
    --    end
    --end
end)

RegisterNUICallback("openBoutique", function(data)
    --TriggerScreenblurFadeOut(1000)
    --SetNuiFocus(false, false)
    --closeUI()
    exports['vNotif']:createNotification({
        type = 'JAUNE',
        content = "Boutique bientot disponible"
    })
   -- OpenBoutiqueCustom()
end)

local AntiSpam = true
RegisterNUICallback("sendReport", function(data)
    TriggerScreenblurFadeOut(1000)
    if data.dontCloseUI ~= true then
        SetNuiFocus(false, false)
        closeUI()
    end
    if AntiSpam then
        AntiSpam = false
        TriggerServerEvent("core:SendReport", token, {name = p:getFullName(), id = GetPlayerServerId(PlayerId()), uniqueID = p:getId(), msg = data.report})
        exports['vNotif']:createNotification({
            type = 'JAUNE',
            content = "Veuillez patienter, votre demande d'aide à bien été reçu."
        })
        SetTimeout(60000, function() AntiSpam = true end)
    else
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            content = "Veuillez patienter avant de formuler un autre besoin."
        })
    end
end)

RegisterNUICallback("openReglages", function(data)
    TriggerScreenblurFadeOut(1000)
    SetNuiFocus(false, false)
    closeUI()
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'),0,-1)
end)

