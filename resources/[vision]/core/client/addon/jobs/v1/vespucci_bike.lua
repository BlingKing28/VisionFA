local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local items = {
    headerImage = 'assets/Skate/header.png',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'CATALOGUE',
    callbackName = 'bikeBuy',
    showTurnAroundButtons = false,
    elements = {
        {
            price = 200,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/VespucciBike/skate.webp',
            name="skate",
            label="Skateboard",
            ownCallbackName = 'bikePreview',
        },
        {
            price = 200,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/VespucciBike/surf.webp',
            name="surfboard",
            label="Planche de surf",
            ownCallbackName = 'bikePreview',
        },    
        {
            price = 200,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/VespucciBike/Cruiser.webp',
            name="cruiser",
            label="Cruiser",
            ownCallbackName = 'bikePreview',
        },
        {
            price = 200,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/VespucciBike/BMX.webp',
            name="bmx",
            label="BMX",
            ownCallbackName = 'bikePreview',
        },
        {
            price = 200,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/VespucciBike/Fixter.webp',
            name="fixter",
            label="Fixter",
            ownCallbackName = 'bikePreview',
        },
        {
            price = 200,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/VespucciBike/Scorcher.webp',
            name="scorcher",
            label="Scorcher",
            ownCallbackName = 'bikePreview',
        },
        {
            price = 200,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/VespucciBike/Tribike.webp',
            name="tribike",
            label="Tri-Cycles",
            ownCallbackName = 'bikePreview',
        },
        {
            price = 200,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/VespucciBike/Tribike2.webp',
            name="tribike2",
            label="Tri-Cycles Endurex",
            ownCallbackName = 'bikePreview',
        },
        {
            price = 200,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/VespucciBike/Tribike3.webp',
            name="tribike3",
            label="Tri-Cycles Whippet",
            ownCallbackName = 'bikePreview',
        },
    }
}

local pedCoords = vector4(-1319.1069335938, -1521.2178955078, 3.4247465133667, 176.52615356445)
local previewPosBike = vector4(-1318.068359375, -1515.7208251953, 3.424747467041, 23.581296920776)

function openVespucciBikeStore(ped)
    playerCoords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamActive(cam, 1)
    SetCamCoord(cam, -1323.3192138672, -1519.2775878906, 4.4367489814758)
    SetCamFov(cam, 30.0)
    PointCamAtCoord(cam, previewPosBike.x, previewPosBike.y, previewPosBike.z + 1.0)
    RenderScriptCams(true, 0, 3000, 1, 0)   
    FreezeEntityPosition(PlayerPedId(), true)
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'MenuCatalogueAchat',
        data = items
    }));
end

RegisterNUICallback("bikeBuy", function(data, cb)
    if p:pay(data.price) then
        if data.name == "surfboard" or data.name == "skate" then
            TriggerSecurGiveEvent("core:addItemToInventory", token, data.name, 1, {})
        else

            local props = vehicle.getProps(data.name)

            TriggerSecurGiveEvent("core:addItemToInventory", token, "bike", 1, {
                renamed = GetLabelText(data.name),
                name = data.name,
                plate = "AFG2D5",
                props = props
            })
        end
        -- ShowNotification("Vous venez d'acheter un(e) "..data.name)

        -- New notif
        exports['vNotif']:createNotification({
            type = 'DOLLAR',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous venez d'acheter ~s un(e) "..data.name
        })

    end
end)

local previewVeh
local previewModel
RegisterNUICallback("bikePreview", function(data, cb)
    if data.name == "skate" then
        if previewVeh ~= nil then
            TriggerEvent('persistent-vehicles/forget-vehicle', previewVeh)
            DeleteEntity(previewVeh)
        end
        if not DoesEntityExist(previewVeh) then
            previewVeh = nil
            previewVeh = entity:CreateObject("p_defilied_ragdoll_01_s", previewPosBike)
            previewVeh = previewVeh.id
            previewModel = "p_defilied_ragdoll_01_s"
            FreezeEntityPosition(previewVeh, true)
        end
    else
        if previewModel == nil or previewModel ~= data.name then
            if previewVeh ~= nil then
                TriggerEvent('persistent-vehicles/forget-vehicle', previewVeh)
                DeleteEntity(previewVeh)
            end
            if not DoesEntityExist(previewVeh) then
                previewVeh = nil
                previewVeh = vehicle.createLocal(data.name, previewPosBike,
                    { plate = "VENTE" })
                previewModel = data.name
                FreezeEntityPosition(previewVeh, true)
                SetVehicleEngineOn(previewVeh, 1, 1, 0)
                SetVehicleDoorsLockedForAllPlayers(previewVeh, 1)
            end
        end
    end
end)

RegisterNUICallback("focusOut", function (data, cb)
    TriggerScreenblurFadeOut(0.5)
    openRadarProperly()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerEvent('persistent-vehicles/forget-vehicle', previewVeh)
    DeleteEntity(previewVeh)
end)


CreateThread(function()
    while p == nil do Wait(1) end
        local ped = entity:CreatePedLocal("a_m_y_roadcyc_01", pedCoords.xyz, pedCoords.w)
        ped:setFreeze(true)
        SetEntityInvincible(ped.id, true)
        SetEntityAsMissionEntity(ped.id, 0, 0)
        SetBlockingOfNonTemporaryEvents(ped.id, true)
        zone.addZone("vespucciBhe",
            pedCoords.xyz,
            "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le magasin",
            function()
                openVespucciBikeStore(ped.id)
            end,
            false, -- Avoir un marker ou non
            -1, -- Id / type du marker
            0.6, -- La taille
            { 0, 0, 0 }, -- RGB
            0, -- Alpha
            2.5
        )
end)