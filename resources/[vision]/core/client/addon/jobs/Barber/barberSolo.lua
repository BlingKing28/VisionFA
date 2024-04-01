local token = nil
local inService = false
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)
local BarberCam = nil
local alreadyLoaded = false
local price = 0

function LoadSoloBarber()
    local actualInmenu = false
    
    CreateThread(function()
        for k, v in pairs(Coiffeur) do
            zone.addZone(
                "action_coiffeurSolo" .. k, -- Nom
                vector3(v.pos.x, v.pos.y, v.pos.z - 0.9), -- Position
                "Appuyer sur ~INPUT_CONTEXT~ pour interagir avec le coiffeur.", -- Text afficher
                function() -- Action qui seras fait
                    if actualInmenu == false then
                        if not IsBarberOnDuty() then
                            StartBarber(v)
                        else
                            exports['vNotif']:createNotification({
                                type = 'ROUGE',
                                content = "un coiffeur est ~s en service"
                            })
                        end
                    end
                end,
                true, -- Avoir un marker ou non
                27, -- Id / type du marker
                0.3, -- La taille
                { 255, 255, 255 }, -- RGB
                170-- Alpha
            )
        end
    end)
    
    local actualCoiffeurData = nil
    local newPlSelectBarber = nil
    function StartBarber(data)
        local playerSelected = ChoicePlayersInZone(3.0, true)
        if playerSelected ~= nil then
            forceHideRadar()
            --if GetPlayerServerId(playerSelected) == GetPlayerServerId(PlayerId()) then             
            --    exports['vNotif']:createNotification({
            --        type = 'ROUGE',
            --        content = "Vous ne pouvez pas vous faire de manucure sur vous même"
            --    }) 
            --    return 
            --end
            actualInmenu = true
            newPlSelectBarber = playerSelected
            TriggerServerEvent("core:PlacePlayerOnSeat", token, GetPlayerServerId(playerSelected), data)
            actualCoiffeurData = data
            DataToSendCoiffeur = {
                buttons= {
                    {
                        name= 'Coupe',
                        width= 'full',
                        image= 'assets/svg/barber/cheveux.svg',
                        hoverStyle= 'fill-black stroke-black',
                        opacity= false,
                        color1= true,
                        color2= true
                    },
                    {
                        name= 'Degradé',
                        width= 'full',
                        image= 'assets/svg/barber/cheveux.svg',
                        hoverStyle= 'fill-black stroke-black',
                        opacity= false,
                        color1= false,
                        color2= false
                        
                    },
                    {
                        name= 'Yeux',
                        width= 'full',
                        image= 'assets/svg/barber/yeux.svg',
                        hoverStyle= 'fill-black stroke-black',
                        opacity= false,
                        color1= false,
                        color2= false
                    },
                    {
                        name= 'Barbe',
                        width= 'full',
                        image= 'assets/svg/barber/barbe.svg',
                        hoverStyle= 'fill-black stroke-black',
                        opacity= true,
                        color1= true,
                        color2= false
                    },
                },
                catalogue = {},
                headerIcon= 'assets/icons/market-cart.png',
                headerIconName= 'HOMME',
                hideItemList= {'Degradé'},
                headerImage= 'assets/headers/header_barbershop.jpg',
                callbackName= 'MenuGrosCatalogueCoiffeur',
                showTurnAroundButtons= false,
                disableSubmit= false
            }
            DataToSendCoiffeur.catalogue = {}
            local tattoos = getDegrader()
            local plyModel = GetEntityModel(GetPlayerPed(GetPlayerFromServerId(GetPlayerServerId(newPlSelectBarber))))
            local sex = "Homme"
            print("plyModel, `mp_f_freemode_01`", plyModel, `mp_f_freemode_01`)
            if plyModel == `mp_f_freemode_01` then 
                sex = "Femme" 
                DataToSendCoiffeur.headerIconName = "FEMME" 
            end
            Wait(50)
            table.insert(DataToSendCoiffeur.catalogue, {
                id= 0,
                label = "Dégrader N°0",
                image= "",
                ownCallbackName = 'previewCoiffeurCB',
                category= "Degradé",
                info = "aucun"
            })
            for i = 1, #tattoos do
                if tattoos[i].Zone == "ZONE_HEAD" then
                    if plyModel == `mp_m_freemode_01` and tattoos[i].HashNameMale ~= "" then
                        table.insert(DataToSendCoiffeur.catalogue, {
                            id= i,
                            label = "Dégrader N°" .. i,
                            image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Barber/".. sex .."/Degrader/"..i..".webp",
                            ownCallbackName = 'previewCoiffeurCB',
                            category= "Degradé",
                            info = tattoos[i]
                        })
                    elseif plyModel == `mp_f_freemode_01` and tattoos[i].HashNameFemale ~= "" then
                        table.insert(DataToSendCoiffeur.catalogue, {
                            id= i,
                            label = "Dégrader N°" .. i,
                            image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Barber/".. sex .."/Degrader/"..i..".webp",
                            ownCallbackName = 'previewCoiffeurCB',
                            category= "Degradé",
                            info = tattoos[i]
                        })
                    end
                end
            end
            for i = 0, 31 do
                table.insert(DataToSendCoiffeur.catalogue, {
                    id= i,
                    label = "Yeux N°" .. i,
                    image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Barber/".. sex .."/Yeux/"..i..".webp",
                    ownCallbackName = 'previewCoiffeurCB',
                    category= "Yeux",
                })
            end
            for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(GetPlayerFromServerId(GetPlayerServerId(playerSelected))), 2) do
                table.insert(DataToSendCoiffeur.catalogue, {
                    id= i,
                    label = "Coiffure N°" .. i,
                    image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Barber/".. sex .."/Coupes/"..i..".webp",
                    ownCallbackName = 'previewCoiffeurCB',
                    category= "Coupe",
                    
                })
            end
            for i = 1, GetNumHeadOverlayValues(1) - 1 do
                table.insert(DataToSendCoiffeur.catalogue, {
                    id= i,
                    label = "Barbe N°" .. i,
                    image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Barber/".. sex .."/Barbes/"..i..".webp",
                    ownCallbackName = 'previewCoiffeurCB',
                    category= "Barbe",
                    
                })
            end
            SendNuiMessage(json.encode({
                type = 'openWebview',
                name = 'MenuGrosCatalogueColor',
                data = DataToSendCoiffeur
            }))
            CreateThread(function()
                while actualInmenu do
                    Wait(0)
                    DisableControlAction(0, 24, true) -- disable attack
                    DisableControlAction(0, 25, true) -- disable aim
                    DisableControlAction(0, 1, true) -- LookLeftRight
                    DisableControlAction(0, 2, true) -- LookUpDown
                    DisableControlAction(0, 142, open)
                    DisableControlAction(0, 18, open)
                    DisableControlAction(0, 322, open)
                    DisableControlAction(0, 106, open)
                    DisableControlAction(0, 263, true) -- disable melee
                    DisableControlAction(0, 264, true) -- disable melee
                    DisableControlAction(0, 257, true) -- disable melee
                    DisableControlAction(0, 140, true) -- disable melee
                    DisableControlAction(0, 141, true) -- disable melee
                    DisableControlAction(0, 142, true) -- disable melee
                    DisableControlAction(0, 143, true) -- disable melee
                end
            end)
            Wait(100)
            SetNuiFocusKeepInput(true)
            SetNuiFocus(true, true)
        end
    end

    RegisterNUICallback("focusOut", function(data, cb)
        if actualInmenu then
            TriggerServerEvent("core:ExitPlayerOnSeatSRV", token, GetPlayerServerId(newPlSelectBarber), actualCoiffeurData)
            Wait(100)
            SetNuiFocusKeepInput(false)
            if BarberCam then
                SetCamActive(BarberCam, 0)
                DestroyCam(BarberCam)
            end
            SetNuiFocus(false, false)
            BarberCam = nil
            newPlSelectBarber = nil
            actualInmenu = false
        end
    end)
    RegisterNUICallback("MenuGrosCatalogueCoiffeur", function(data, cb)
        print("cb1", json.encode(data))
        if not IsBarberOnDuty() then
            if data.changedData then
                --HairCutAnim()
                
                print("price", price)
                if p:pay(tonumber(price)) then 
                    TriggerServerEvent("core:applySkinBarberSRV", token, GetPlayerServerId(newPlSelectBarber), data.changedData)
                    price = 0
                else
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        content = "~c Vous n'avez ~s pas assez d'argent"
                    })
                end
                --{"changedData":{"Coupe":{"item":{"label":"Coiffure N°41","id":41,"ownCallbackName":"previewCoiffeurCB","category":"Coupe"},"color1":33}}}
                --closeUI()
                --Wait(100)
                --SetNuiFocusKeepInput(false)
                --SetNuiFocus(false, false)
            end
        end
    end)


    RegisterNUICallback("MenuGrosCatalogueCoiffeur", function(data)
        print("cb2")
        if not IsBarberOnDuty() then
            TriggerServerEvent("core:SendUpdateHairToServ1", token, data, GetPlayerServerId(newPlSelectBarber))
        end
    end)

    RegisterNUICallback("previewCoiffeurCB", function(data)
        print("cb3", json.encode(data))
        if not IsBarberOnDuty() then
            if data.category == "Degradé" then
               price = 100
            elseif data.category == "Barbe" then
                price = 150
            elseif data.category == "Coupe" then
                price = 250
            elseif data.category == "Yeux" then
                price = 300
            end
            TriggerServerEvent("core:SendUpdateHairToServ2", token, data, GetPlayerServerId(newPlSelectBarber))
            --CreateCameraBarber(GetPlayerPed(GetPlayerFromServerId(GetPlayerServerId(newPlSelectBarber))), data.category)
        end
    end)
end

local angleY = 0.0
local angleZ = 0.0
local radius = 1.5
local mouseX = 0.0
local mouseY = 0.0

function ProcessNewPosition()

    if IsControlPressed(0, 174) or IsDisabledControlPressed(0, 174) then 
        mouseX = mouseX + 0.1
    elseif IsControlPressed(0, 175) or IsDisabledControlPressed(0, 175) then 
        mouseX = mouseX - 0.1
    else
        mouseX = 0.0
        mouseY = 0.0
    end

    if (IsInputDisabled(0)) then
        --mouseX = GetDisabledControlNormal(1, 1) * 8.0
        --mouseY = GetDisabledControlNormal(1, 2) * 8.0
    else
        mouseX = GetDisabledControlNormal(1, 1) * 1.5
        mouseY = GetDisabledControlNormal(1, 2) * 1.5
    end

    angleZ = angleZ - mouseX -- around Z axis (left / right)
    angleY = angleY + mouseY -- up / down
    -- limit up / down angle to 90°
    if (angleY > 89.0) then angleY = 89.0 elseif (angleY < -89.0) then angleY = -89.0 end
    
    local pCoords = GetEntityCoords(PlayerPedId())
    
    local behindCam = {
        x = pCoords.x + ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * (radius + 0.5),
        y = pCoords.y + ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * (radius + 0.5),
        z = pCoords.z + ((Sin(angleY))) * (radius + 0.5)
    }
    local rayHandle = StartShapeTestRay(pCoords.x, pCoords.y, pCoords.z + 0.5, behindCam.x, behindCam.y, behindCam.z, -1, PlayerPedId(), 0)
    local a, hitBool, hitCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
    
    local maxRadius = radius
    if (hitBool and Vdist(pCoords.x, pCoords.y, pCoords.z + 0.5, hitCoords) < radius + 0.5) then
        maxRadius = Vdist(pCoords.x, pCoords.y, pCoords.z + 0.5, hitCoords)
    end
    
    local offset = {
        x = ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * maxRadius,
        y = ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * maxRadius,
        z = ((Sin(angleY))) * maxRadius
    }
    
    local pos = {
        x = pCoords.x + offset.x,
        y = pCoords.y + offset.y,
        z = pCoords.z + offset.z
    }
    return pos
end

function ProcessCamControls(cam)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    -- disable 1st person as the 1st person camera can cause some glitches
    DisableFirstPersonCamThisFrame()
    
    -- calculate new position
    local newPos = ProcessNewPosition()

    -- focus cam area
    SetFocusArea(newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0)
    
    -- set coords of cam
    SetCamCoord(cam, newPos.x, newPos.y, newPos.z)
    
    -- set rotation
    PointCamAtCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.5)
end

function CreateCameraBarber(player, typecam)
    if BarberCam == nil then
        BarberCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    end
    SetCamActive(BarberCam, 1)
    local coord = GetEntityCoords(player)
   -- local formattedcamval = {coord.x, coord.y, coord.z}
    --if typecam == "Degradé" or typecam == "Barbe" or typecam == "Coupe" or typecam == "Yeux" then 
    local formattedcamval = {coord.x+(GetEntityForwardX(player)*2), coord.y, coord.z+0.9, 50, 0.2}
    --elseif typecam == "Pilosité" then 
    --    formattedcamval = {coord.x-1.0, coord.y, coord.z+0.7, 55, 0.6}
    --elseif typecam == "Manucure" then 
    --    formattedcamval = {coord.x-1.0, coord.y, coord.z+0.3, 40, -0.1}
   -- end
    SetCamCoord(BarberCam, formattedcamval[1], formattedcamval[2], formattedcamval[3])
    PointCamAtEntity(BarberCam, player)
    PointCamAtCoord(BarberCam, coord.x, coord.y, coord.z + formattedcamval[5])
    SetCamFov(BarberCam, formattedcamval[4] + 0.1)
    RenderScriptCams(true, 0, 3000, 1, 0)
    while true do 
        Wait(1)
        ProcessCamControls(BarberCam)
    end
end

CreateThread(function()
    local inDuty
    Wait(1000)
    while true do
        inDuty = TriggerServerCallback("core:getNumberOfDuty", token, "barber") + TriggerServerCallback("core:getNumberOfDuty", token, "barber2")
        if inDuty == 0 then 
            if not alreadyLoaded then
                LoadSoloBarber()
                alreadyLoaded = true
            end
        else
            if alreadyLoaded then
                unloadSoloBarber()
                alreadyLoaded = false
            end
        end
        Wait(5000)
    end
end)

function unloadSoloBarber()
    for k, v in pairs(Coiffeur) do
        zone.removeZone("action_coiffeurSolo" .. k)
    end
end