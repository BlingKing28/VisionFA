local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

function OpenIdentityCard(dl,
    exp,
    ln,
    fn,
    dob,
    id, class,
    sex,
    hair,
    eyes,
    hgt,
    wgt,
    iss)
    SendNUIMessage({
        type = "openWebview",
        name = "PermisConduire",
        data = {
            dl = dl,
            exp = exp,
            ln = ln,
            fn = fn,
            dob = dob,
            class = class,
            sex = sex,
            hair = hair,
            eyes = eyes,
            hgt = hgt,
            wgt = wgt,
            iss = iss,
            isDonnor = false
        }
    })
end

RegisterNetEvent('core:UseIdentityCard')
AddEventHandler("core:UseIdentityCard", function(dl,
    exp,
    ln,
    fn,
    dob,
    id, class,
    sex,
    hair,
    eyes,
    hgt,
    wgt,
    iss)
    OpenIdentityCard(dl,
    exp,
    ln,
    fn,
    dob,
    id, class,
    sex,
    hair,
    eyes,
    hgt,
    wgt,
    iss)
    -- wait a few seconds before closing the webview
    Wait(7000)
    SendNUIMessage({
        type = "closeWebview",
        name = "PermisConduire"
    })
end)

local buyposIdentity = {
    {pos = vector3(-1099.4544677734, -840.42669677734, 19.00115776062)}, -- lspd
    {pos = vector3(2826.5090332031, 4732.2978515625, 47.627410888672)}, -- lssd sandy
    {pos = vector3(-446.62487792969, 6012.8037109375, 32.28868865966)}, -- lssd paleto
}

CreateThread(function()
    while zone == nil do
        Wait(0)
    end
    for x,y in pairs(buyposIdentity) do
        zone.addZone("identity-card" .. x, y.pos,
            "Appuyer sur ~INPUT_CONTEXT~ pour acheter une carte d'identité (10$)", function()
                local sold = false
                for k, v in pairs(p:getInventaire()) do
                    if v.name == "money" then
                        if v.count >= 10 then

                            sold = true
                            
                            TriggerEvent("nuiPapier:client:startCreation", 6)

                        end
                    end
                end
                if not sold then
                    -- ShowNotification("Vous n'avez ~r~pas assez d'argent~s~")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous n'avez ~s pas assez d'argent"
                    })

                end
        end, false)
    end
end)
