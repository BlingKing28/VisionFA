local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)


local items = {
    headerImage = 'assets/Digital/header.png',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    callbackName = 'digitalDenBuy',
    showTurnAroundButtons = false,
    elements = {
        {
            price = 450,
            image = "./assets/Digital/img0.png",
            name = "phone",
            label = "Téléphone - 450$",
        },
        {
            price = 300,
            image = "./assets/Digital/img1.png",
            name = "gps",
            label = "GPS - 300$",
        },
        {
            price = 450,
            image = "./assets/Digital/img2.png",
            name = "radio",
            label = "Radio - 450$",
        },
        {
            price = 300,
            image = "./assets/inventory/items/boombox.png",
            name = "boombox",
            label = "Boombox - 300$",
        },
        --{
        --    price = 100,
        --    image = "./assets/inventory/items/laptop.png",
        --    name =  "laptop",
        --    label = "Ordinateur - 20$",
        --},
    }
}

local pedCoords = vector4(-1208.14453125, -1501.9516601563, 3.373884677887, 128.97775268555)

function openDigitalDenStore(ped)
    local ltdDuty = TriggerServerCallback("core:getNumberOfDuty", token, 'ltdsud') + TriggerServerCallback("core:getNumberOfDuty", token, 'ltdmirror')
    if ltdDuty and ltdDuty < 1 then
        playerCoords = GetEntityCoords(PlayerPedId())
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamActive(cam, 1)
        SetCamCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.7)
        SetCamFov(cam, 35.0)
        PointCamAtCoord(cam, pedCoords.x, pedCoords.y, pedCoords.z + 1.5)
        RenderScriptCams(true, 0, 3000, 1, 0)   
        FreezeEntityPosition(PlayerPedId(), true)
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogueAchat',
            data = items
        }));
    else
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            content = "~c Une personne du LTD est en service, allez le voir"
        })
    end
end


RegisterNUICallback("digitalDenBuy", function(data, cb)
    if p:pay(data.price) then
        TriggerSecurGiveEvent("core:addItemToInventory", token, data.name, 1, {})
        -- ShowNotification("Vous venez d'acheter un(e) "..data.name)

        -- New notif
        exports['vNotif']:createNotification({
            type = 'DOLLAR',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous venez d'acheter ~s un(e) "..data.name
        })

    end
end)

RegisterNUICallback("focusOut", function (data, cb)
    TriggerScreenblurFadeOut(0.5)
    openRadarProperly()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    FreezeEntityPosition(PlayerPedId(), false)
end)

local ped = nil

CreateThread(function()
    ped = entity:CreatePedLocal("a_f_y_business_01", pedCoords.xyz, pedCoords.w)
    ped:setFreeze(true)
    SetEntityInvincible(ped.id, true)
    SetEntityAsMissionEntity(ped.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped.id, true)
    zone.addZone("digitalDen",
        pedCoords.xyz,
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le magasin",
        function()
            openDigitalDenStore(ped.id)
        end,
        false, -- Avoir un marker ou non
        -1, -- Id / type du marker
        0.6, -- La taille
        { 0, 0, 0 }, -- RGB
        0, -- Alpha
        2.5
    )
end)