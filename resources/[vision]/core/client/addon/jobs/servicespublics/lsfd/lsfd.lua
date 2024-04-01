local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

--[[ local lsfdPropsPlaced = {}

local function SpawnObject(obj, name)
    local coords, forward = GetEntityCoords(p:ped()), GetEntityForwardVector(p:ped())
    local objCoords = (coords + forward * 2.5)
    local placed = false
    local heading = p:heading()

    local objS = entity:CreateObject(obj, objCoords)
    objS:setPos(objCoords)
    objS:setHeading(heading)
    PlaceObjectOnGroundProperly(objS.id)

    while not placed do
        coords, forward = GetEntityCoords(p:ped()), GetEntityForwardVector(p:ped())
        objCoords = (coords + forward * 2.5)
        objS:setPos(objCoords)
        PlaceObjectOnGroundProperly(objS.id)
        objS:setAlpha(170)
        SetEntityCollision(objS.id, false, true)

        if IsControlPressed(0, 190) then
            heading = heading + 0.5
        elseif IsControlPressed(0, 189) then
            heading = heading - 0.5
        end

        SetEntityHeading(objS.id, heading)

        ShowHelpNotification(
            "Appuyez sur ~INPUT_CONTEXT~ pour placer l'objet\n~INPUT_FRONTEND_LEFT~ ou ~INPUT_FRONTEND_RIGHT~ Pour faire pivoter l'objet")
        if IsControlJustPressed(0, 38) then
            placed = true
        end
        Wait(0)
    end
    SetEntityCollision(objS.id, true, true)
    -- SetEntityInvincible(objS.id, true)
    -- objS:setFreeze(true)
    objS:resetAlpha()
    local netId = objS:getNetId()
    if netId == 0 then
        objS:delete()
    end
    SetNetworkIdCanMigrate(netId, true)
    table.insert(lsfdPropsPlaced, {
        nom = name,
        prop = objS.id
    })
end ]]

lsfdDuty = false

function LoadLsfdJob()

    local coffrePos = { vector3(-1680.13, 63.65, 67.5) } -- TODO -> Add pos

    local vehicleOut = nil
    local currentVeh = nil
    
    zone.addZone(
        "society_lsfd_custom",
        vector3(1200.6201171875, -1497.5433349609, 33.692821502686),
        "Appuyer sur ~INPUT_CONTEXT~ pour éditer votre vehicule",
        function()
            local veh = p:currentVeh()
            if GetVehicleClass(veh)== 18 then
               extraVeh(veh)
            else
               exports['vNotif']:createNotification({
                  type = 'ROUGE',
                  duration = 5, -- In seconds, default:  4
                  content = "Ceci n'est ~s pas un véhicule de fonction"
                 })     
            end
        end,
        true,
        39, -- Id / type du marker
        0.5, -- La taille
        { 203, 75, 0 }, -- RGB
        170-- Alpha
    )
    zone.addZone(
        "society_lsfd2_custom",
        vector3(2521.4545898438, 4240.7514648438, 40.418788909912),
        "Appuyer sur ~INPUT_CONTEXT~ pour éditer votre vehicule",
        function()
            local veh = p:currentVeh()
            if GetVehicleClass(veh)== 18 then
               extraVeh(veh)
            else
               exports['vNotif']:createNotification({
                  type = 'ROUGE',
                  duration = 5, -- In seconds, default:  4
                  content = "Ceci n'est ~s pas un véhicule de fonction"
                 })     
            end
        end,
        true,
        39, -- Id / type du marker
        0.5, -- La taille
        { 203, 75, 0 }, -- RGB
        170-- Alpha
    )
    zone.addZone("lsfd_vestiaire", vector3(1211.4499511719, -1474.7015380859, 33.857032775879),--1211.5673828125, -1474.8977050781, 34.857074737549),  -- TODO -> Add pos
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir", function()
            LoadLSFDVestiaire()
        end, true,
        27,
        0.5,
        { 51, 204, 255 }, -- RGB
        170, -- Alpha
        1.5
    )

    zone.addZone("lsfd_vestiaire_nord", vector3(2502.7553710938, 4225.6044921875, 39.418807983398),--1211.5673828125, -1474.8977050781, 34.857074737549),  -- TODO -> Add pos
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir", function()
            LoadLSFDVestiaire()
        end, true,
        27,
        0.5,
        { 51, 204, 255 }, -- RGB
        170, -- Alpha
        1.5
    )

    zone.addZone("lsfd_armory", vector3(1193.8162841797, -1475.7797851563, 33.857032775879),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir l'armurerie ", 
        function()
            OpenLSFDITEMMenu()
        end,
        true, -- Avoir un marker ou non
        27, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170,-- Alpha
        1.5 -- Interact dist
    )

    zone.addZone("lsfd_armory_nord", vector3(2506.7717285156, 4224.7622070313, 39.418807983398),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir l'armurerie ", 
        function()
            OpenLSFDITEMMenu()
        end,
        true, -- Avoir un marker ou non
        27, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170,-- Alpha
        1.5 -- Interact dist
    )

    local items = {
        headerImage = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Banners/LSFD.webp",
        headerIcon = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Banners/icon.webp',
        headerIconName = 'CATALOGUE',
        callbackName = 'armoryTakeLSFD',
        showTurnAroundButtons = false,
        multipleSelection = true,
        elements = {
            {
                id = 1,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Jumelles.webp",
                price = 0,
                name = "jumelle",
                label = "Jumelles",
            },
            {
                id = 2,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/samskev.webp",
                price = 100,
                name = "samskev",
                label = "Kevlar Class C",
            },
        }
    }

    function OpenLSFDITEMMenu()
        FreezeEntityPosition(PlayerPedId(), true)
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogueAchat',
            data = items
        }));

        RegisterNUICallback("focusOut", function (data, cb)
            TriggerScreenblurFadeOut(0.5)
            openRadarProperly()
            RenderScriptCams(false, false, 0, 1, 0)
            DestroyCam(cam, false)
            FreezeEntityPosition(PlayerPedId(), false)
        end)
    end

    zone.addZone("lsfd_garage", vector3(1235.9140625, -1458.9482421875, 33.934341430664),
        "Appuyer sur ~INPUT_CONTEXT~ pour rentrer dans le garage", function()
            if IsPedInAnyVehicle(p:ped(), false) then
                local veh = GetVehiclePedIsIn(p:ped(), false)
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                DeleteEntity(veh)
            end
        end, true,
        36, 0.5, { 255, 0, 0 }, 255)

        zone.addZone("lsfd_garage_nord", vector3(2486.8488769531, 4264.4448242188, 39.095760345459),
        "Appuyer sur ~INPUT_CONTEXT~ pour rentrer dans le garage", function()
            if IsPedInAnyVehicle(p:ped(), false) then
                local veh = GetVehiclePedIsIn(p:ped(), false)
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                DeleteEntity(veh)
            end
        end, true,
        36, 0.5, { 255, 0, 0 }, 255)

    zone.addZone("lsfd_garage_vehicle", vector3(1207.2319335938, -1466.7603759766, 33.857051849365),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir la liste des véhicules", function()
            openGarageMenu()
            forceHideRadar()
        end, true, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    zone.addZone("lsfd_garage_vehicle_nord", vector3(2522.3918457031, 4224.4443359375, 39.418796539307),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir la liste des véhicules", function()
            openGarageMenu()
            forceHideRadar()
        end, true, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    zone.addZone("society_lsfd", vector3(1187.0948486328, -1475.8818359375, 33.857032775879),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les actions d'entreprise", function()
            OpenSocietyMenu() -- TODO: fini le menu society
        end, true, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    zone.addZone("society_lsfd_nord", vector3(2531.2998046875, 4195.7739257813, 39.415069580078),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les actions d'entreprise", function()
            OpenSocietyMenu() -- TODO: fini le menu society
        end, true, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    zone.addZone("stockage_lsfd", vector3(1214.5556640625, -1465.98046875, 33.85701751709),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le stockage lsfd", function()
            OpenInventorySocietyMenu() -- TODO: fini le menu society
        end, true, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    zone.addZone("stockage_lsfd_nord", vector3(2516.6101074219, 4207.8334960938, 39.415016174316),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le stockage lsfd", function()
            OpenInventorySocietyMenu() -- TODO: fini le menu society
        end, true, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone("coffre_lsfd", vector3(-1680.13, 63.65, 67.5), 
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les casiers", function()
            OpenlsfdCasier() -- TODO: fini le menu society
        end, false, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone("coffre_lsfd_nord", vector3(2501.3930664063, 4216.86328125, 39.4150390625), 
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les casiers", function()
            OpenlsfdCasier() -- TODO: fini le menu society
        end, false, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    -- DEV
    local tenueH = {
        ['tshirt_1'] = 229, ['tshirt_2'] = 0,
        ['torso_1'] = 530, ['torso_2'] = 1,
        ['arms'] = 11, ['arms_2'] = 0,
        ['pants_1'] = 166, ['pants_2'] = 1,
        ['shoes_1'] = 24, ['shoes_2'] = 0,
        ['bproof_1'] = 0, ['bproof_2'] = 0,
        ['helmet_1'] = -1, ['helmet_2'] = 0,
        ['bags_1'] = 168, ['bags_2'] = 6,
    }
    local tenueF = {
        ['tshirt_1'] = 265, ['tshirt_2'] = 0,
        ['torso_1'] = 550, ['torso_2'] = 1,
        ['arms'] = 9, ['arms_2'] = 0,
        ['pants_1'] = 172, ['pants_2'] = 1,
        ['shoes_1'] = 24, ['shoes_2'] = 0,
        ['bproof_1'] = 0, ['bproof_2'] = 0,
        ['helmet_1'] = -1, ['helmet_2'] = 0,
        ['bags_1'] = 164, ['bags_2'] = 6,
    }
    --function LSFDVestiaireDev()
    --    exports['vNotif']:createNotification({
    --        type = 'JAUNE',
    --        content = "Vous venez de récupérer votre tenue"
    --    })

    --    if p:isMale() then
    --        TriggerSecurGiveEvent("core:addItemToInventory", token, "outfit", 1, {renamed = "Tenue LSFD HOMME", data = tenueH})
    --    else
    --        TriggerSecurGiveEvent("core:addItemToInventory", token, "outfit", 1, {renamed = "Tenue LSFD FEMME", data = tenueF})
    --    end
    --end
    --

    function lsfdActionDuty()
        if lsfdDuty then
            TriggerServerEvent('core:DutyOff', 'lsfd')
        --[[             ShowAdvancedNotification("Centrale", "~b~Dispatch", "Vous avez quitté votre service", "CHAR_CALL911",
                "CHAR_CALL911") ]]

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s quitté ~c votre service"
            })

            lsfdDuty = false
            Wait(5000)
        else
            TriggerServerEvent('core:DutyOn', 'lsfd')
        --[[             ShowAdvancedNotification("Centrale", "~b~Dispatch", "Vous avez pris votre service", "CHAR_CALL911",
                "CHAR_CALL911") ]]


            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s pris ~c votre service"
            })


            lsfdDuty = true
            Wait(5000)
        end
    end

    local openRadial = false

    local allVehicleList = {}
    local selected_vehicle = nil

    local vehs = nil
    ---OpenVeh

    local listVeh = {
        headerImage = 'assets/LSFD/header_lsfd.jpg',
        headerIcon = 'assets/LSFD/logo_vehicule.png',
        headerIconName = 'VEHICULE',
        callbackName= 'Menu_LSFD_vehicule_callback',
        elements = {
            {
                label = 'Stanier LSFD',
                spawnName = 'LSFD',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/LSFD.webp",
                category= 'VL',
                subCategory= 'VL'
            },
            {
                label = 'Buffalo S LSFD',
                spawnName = 'LSFDBUFS',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/LSFDBUFS.webp",
                category= 'VL',
                subCategory= 'VL'
            },
            {
                label = 'Rescue',
                spawnName = 'LSFD4',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/LSFD4.webp",
                category= 'Intervention',
                subCategory= 'Intervention'
            },
            {
                label = 'Engine',
                spawnName = 'LSFDTRUCK',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/LSFDTRUCK.webp",
                category= 'Intervention',
                subCategory= 'Intervention'
            },
            {
                label = 'First Response',
                spawnName = 'LSFD5',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/LSFD5.webp",
                category= 'Intervention',
                subCategory= 'Intervention'
            },
            {
                label = 'Squad',
                spawnName = 'LSFDTRUCK3',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/LSFDTRUCK3.webp",
                category= 'Division',
                subCategory= 'Division'
            },
            {
                label = 'Truck',
                spawnName = 'LSFDTRUCK2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/lsfdtruck2.webp",
                category= 'Division',
                subCategory= 'Division'
            },
            {
                label = 'Swift Water',
                spawnName = 'LSFD2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/LSFD2.webp",
                category= 'Division',
                subCategory= 'Division'
            },
            {
                label = 'Buffalo STX',
                spawnName = 'ems2stx',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/ems2stx.webp",
                category= 'Division',
                subCategory= 'Division'
            },
            {
                label = 'Caracara LSFD',
                spawnName = 'samscara',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/samscara.webp",
                category= 'VL',
                subCategory= 'VL'
            },
            {
                label = 'Stalker FM LSFD',
                spawnName = 'emsstalker',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/emsstalkerfm.webp",
                category= 'Division',
                subCategory= 'Division'
            },
            {
                label = 'Mobile Operation Command',
                spawnName = 'mocpacker',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/mocpacker.webp",
                category= 'Division',
                subCategory= 'Division'
            },
            {
                label = 'Stalker LSFD',
                spawnName = 'emsstalker',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/emsstalker.webp",
                category= 'VL',
                subCategory= 'VL'
            },
            {
                label = 'Ladder Engine',
                spawnName = 'fdlcladder',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/fdlcladder.webp",
                category= 'Intervention',
                subCategory= 'Intervention'
            },
            {
                label = 'Heavy Rescue',
                spawnName = 'fdlcheavy',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/fdlcheavy.webp",
                category= 'Intervention',
                subCategory= 'Intervention'
            },
            --[[             {
                label = 'EMSSWIFT',
                spawnName = 'EMSSWIFT',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/EMSSWIFT.webp",
                category= 'Marina',
                subCategory= 'Marina'
            },
            {
                label = 'LSFDMAV',
                spawnName = 'LSFDMAV',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/LSFDMAV.webp",
                category= 'Marina',
                subCategory= 'Marina'
            }, ]]
            
        },
    }
        

    function openGarageMenu()
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogue',
            data = listVeh
        }))
    end

    local listHeli = {
        headerImage = 'assets/LSFD/header_lsfd.jpg',
        headerIcon = 'assets/LSFD/logo_vehicule.png',
        headerIconName = 'VEHICULE',
        callbackName= 'Menu_LSFD_heli_callback',
        elements = {
            {
                label = 'AS332 LSFD',
                spawnName = 'AS332',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/AS332.webp",
                category= 'Marina',
                subCategory= 'Marina'
            },
            {
                label = 'Maverick LSFD',
                spawnName = 'LSPDMAV',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/LSPDMAV.webp",
                category= 'Marina',
                subCategory= 'Marina'
            },
        }
    }

    function openGarageHeliLSFDMenu()
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogue',
            data = listHeli
        }))
    end

    local listBoat = {
        headerImage = 'assets/LSFD/header_lsfd.jpg',
        headerIcon = 'assets/LSFD/logo_vehicule.png',
        headerIconName = 'VEHICULE',
        callbackName= 'Menu_LSFD_boat_callback',
        elements = {
            {
                label = 'Jet-ski',
                spawnName = 'emsseashark',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/emsseashark.webp",
                category= 'Division',
                subCategory= 'Marina'
            },
            {
                label = 'Dinghy',
                spawnName = 'poldinghy',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/poldinghy.webp",
                category= 'Division',
                subCategory= 'Marina'
            },
        }
    }

    function openGarageLSFDBoatMenu()
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogue',
            data = listBoat
        }))
    end


    zone.addZone(
        "spawn_lsfd_heli",
        vector3(-736.0352, -1502.7567, 4.0005),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        function()
            openGarageHeliLSFDMenu()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170--
    )

    zone.addZone(
        "spawn_lsfd_heli_nord",
        vector3(2498.3447265625, 4265.6328125, 38.359069824219),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        function()
            openGarageHeliLSFDMenu()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170--
    )


    zone.addZone(
        "spawn_lsfd_heli_delete",
        vector3(-724.77893066406, -1444.1192626953, 5.0005230903625),
        "Appuyer sur ~INPUT_CONTEXT~ pour ranger le véhicule",
        function()
            if IsPedInAnyVehicle(p:ped(), false) then
                local veh = GetVehiclePedIsIn(p:ped(), false)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                DeleteEntity(veh)

            end
        end,
        true,
        36, 0.5, { 255, 0, 0 }, 255, 7
    )

    zone.addZone(
        "spawn_lsfd_boat",
        vector3(-806.29077148438, -1496.9188232422, 0.6),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        function()
            openGarageLSFDBoatMenu()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170--
    )

    zone.addZone(
        "society_lsfdBoat_delete",
        vector3(-797.44512939453, -1517.0225830078, 1.0),
        "Appuyer sur ~INPUT_CONTEXT~ pour ranger le véhicule",
        function()
            if IsPedInAnyVehicle(p:ped(), false) then
                local veh = GetVehiclePedIsIn(p:ped(), false)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                DeleteEntity(veh)

            end
        end,
        true,
        35, 0.6, { 255, 0, 0 }, 170
    )

    RegisterNUICallback("focusOut", function (data, cb)
        TriggerScreenblurFadeOut(0.5)
        DisplayHud(true)
        openRadarProperly()
    end)

    local casierOpen = false
    function OpenlsfdCasier()
        if not casierOpen then
            casierOpen = true

            CreateThread(function()
                while casierOpen do
                    Wait(0)
                    DisableControlAction(0, 1, casierOpen)
                    DisableControlAction(0, 2, casierOpen)
                    DisableControlAction(0, 142, casierOpen)
                    DisableControlAction(0, 18, casierOpen)
                    DisableControlAction(0, 322, casierOpen)
                    DisableControlAction(0, 106, casierOpen)
                    DisableControlAction(0, 24, true) -- disable attack
                    DisableControlAction(0, 25, true) -- disable aim
                    DisableControlAction(0, 263, true) -- disable melee
                    DisableControlAction(0, 264, true) -- disable melee
                    DisableControlAction(0, 257, true) -- disable melee
                    DisableControlAction(0, 140, true) -- disable melee
                    DisableControlAction(0, 141, true) -- disable melee
                    DisableControlAction(0, 142, true) -- disable melee
                    DisableControlAction(0, 143, true) -- disable melee
                end
            end)
            SetNuiFocusKeepInput(true)
            SetNuiFocus(true, true)
            Citizen.CreateThread(function()
                SendNUIMessage({
                    type = "openWebview",
                    name = "Casiers",
                    data = {
                        count = 100
                    }
                })
            end)
        else
            casierOpen = false
            SetNuiFocusKeepInput(false)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 142, true)
            EnableControlAction(0, 18, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 106, true)
            SetNuiFocus(false, false)
            SendNuiMessage(json.encode({
                type = 'closeWebview'
            }))
            return
        end
    end

    RegisterNUICallback("focusOut", function(data, cb)
        if casierOpen then
            casierOpen = false
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 142, true)
            EnableControlAction(0, 18, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 106, true)
            openRadarProperly()
        end
        cb({})
    end)

    RegisterNUICallback("casier__callback", function(data)
        local casier = TriggerServerCallback("core:GetAllCasierByJob", pJob)
        if casier == nil then
            TriggerServerEvent("core:CreateNewCasier", token, pJob, data.numero)
            casier = TriggerServerCallback("core:GetAllCasierByJob", pJob)
        end

        if casier ~= nil and casier[data.numero] == nil then
            TriggerServerEvent("core:CreateNewCasier", token, pJob, data.numero)
            casier = TriggerServerCallback("core:GetAllCasierByJob", pJob)
        end

        if casier ~= nil and casier[data.numero] ~= nil then
            OpenInventoryCasier(pJob, data.numero)
        end
        -- OpenInventorySocietyMenu()
    end)

    local openRadial = false
    local lsfdDuty = false
    function lsfdActionDuty()
        openRadial = false
        closeUI()
        if lsfdDuty then
            TriggerServerEvent('core:DutyOff', 'lsfd')
            --[[ShowAdvancedNotification("Centrale", "~b~Dispatch", "Vous avez quitté votre service", "CHAR_CALL911",
                "CHAR_CALL911") ]]

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s quitté ~c votre service"
            })

            lsfdDuty = false
            Wait(5000)
        else
            TriggerServerEvent('core:DutyOn', 'lsfd')
            --[[ShowAdvancedNotification("Centrale", "~b~Dispatch", "Vous avez pris votre service", "CHAR_CALL911",
                "CHAR_CALL911") ]]
            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s pris ~c votre service"
            })

            lsfdDuty = true
            Wait(5000)
        end
    end

    
    function HealthPatientLSFD()
        if lsfdDuty then
            openRadial = false
            closeUI()
            local closestPlayer = ChoicePlayersInZone(2.0)
            if closestPlayer == nil then
                return
            end
        
            globalTarget = GetPlayerServerId(closestPlayer)
            
            if closestPlayer ~= PlayerId() then
                local cPed = GetPlayerPed(closestPlayer)
                local health = GetEntityHealth(cPed)
                
                if health > 0 then
                    p:PlayAnim("amb@medic@standing@kneel@base", "base", 1)
                    Wait(5000)
                    ClearPedTasks(p:ped())
                    if health > 0 then
                        TriggerServerEvent('core:HealthPlayer', token, globalTarget)
                    end
                end
            else
                local cPed = GetPlayerPed(closestPlayer)
                local health = GetEntityHealth(cPed)
                if health > 0 then
                    p:PlayAnim("amb@medic@standing@kneel@base", "base", 1)
                    Wait(5000)
                    ClearPedTasks(p:ped())
                    if health > 0 then
                        TriggerServerEvent('core:HealthPlayer', token, globalTarget)
                    end
                end
            end
        else
            -- ShowNotification("Vous n'êtes pas en service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous n'êtes ~s pas en service"
            })
        end
    end

    function FactureLSFD()
        if lsfdDuty then
            openRadial = false
            closeUI()
            TriggerEvent("nuiPapier:client:startCreation",2)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function CertificatLSFD()
        if lsfdDuty then
            openRadial = false
            closeUI()
            TriggerEvent("nuiPapier:client:startCreation",1)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function makeRenfortCall()
        if lsfdDuty then
            openRadial = false
            closeUI()
            TriggerServerEvent('core:makeCall', "lsfd", p:pos(), false, "Besoin de renfort")
        else
            -- ShowNotification("~r~Vous n'êtes pas en service")
                    
            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                duration = 5, -- In seconds, default:  4
                content = "Vous n'êtes ~s pas en service"
            }) 
        end
    end

    function CreateAdvert()
        if lsfdDuty then
            openRadial = false
            closeUI()
            CreateJobAnnonce()
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function RevivePatientLSFD()
        if lsfdDuty then
            openRadial = false
            closeUI()
            local closestPlayer = ChoicePlayersInZone(2.0, false)
            if closestPlayer == nil then
                return
            end
        
            globalTarget = GetPlayerServerId(closestPlayer)
    
            local playerheading = GetEntityHeading(p:ped())
            local coords = GetEntityCoords(p:ped())
            local playerlocation = GetEntityForwardVector(p:ped())
            
            TriggerServerEvent('core:RevivePlayer', token, globalTarget)
            TriggerServerEvent("core:reviveanimrevived", globalTarget, playerheading, coords, playerlocation)
        else
            -- ShowNotification("Tu n'es pas en service")
    
            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Tu n'es ~s pas en service"
            })
        end
    end

    local hose = false
    function ToggleHose()
        if lsfdDuty then
            ExecuteCommand('hose')
            if hose == false then
                hose = true
            else
                hose = false
            end
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Tu n'es ~s pas en service"
            })
        end
    end

    local foam = false
    function ToggleFoam()
        if lsfdDuty then
            if hose == false then
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    content = "La lance n'est pas déployée"
                })
            else
                ExecuteCommand('foam')
                if foam == false then
                    exports['vNotif']:createNotification({
                        type = 'VERT',
                        content = "La mousse est activée"
                    })
                    foam = true
                else
                    exports['vNotif']:createNotification({
                        type = 'VERT',
                        content = "La mousse est désactivée"
                    })
                    foam = false
                end
            end
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Tu n'es ~s pas en service"
            })
        end
    end

    Keys.Register("F2", "F2", "Faire un appel de renfort", function()
        makeRenfortCall()
    end)

    function OpenRadialLSFDMenu()
        if not openRadial then
            openRadial = true
            CreateThread(function()
                while openRadial do
                    Wait(0)
                    DisableControlAction(0, 1, openRadial)
                    DisableControlAction(0, 2, openRadial)
                    DisableControlAction(0, 142, openRadial)
                    DisableControlAction(0, 18, openRadial)
                    DisableControlAction(0, 322, openRadial)
                    DisableControlAction(0, 106, openRadial)
                    DisableControlAction(0, 24, true) -- disable attack
                    DisableControlAction(0, 25, true) -- disable aim
                    DisableControlAction(0, 263, true) -- disable melee
                    DisableControlAction(0, 264, true) -- disable melee
                    DisableControlAction(0, 257, true) -- disable melee
                    DisableControlAction(0, 140, true) -- disable melee
                    DisableControlAction(0, 141, true) -- disable melee
                    DisableControlAction(0, 142, true) -- disable melee
                    DisableControlAction(0, 143, true) -- disable melee
                end
            end)
            SetNuiFocusKeepInput(true)
            SetNuiFocus(true, true)
            closeUI()
            Wait(200)
            CreateThread(function()
                function OpenSubRadialPapiers()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "ANNONCE",
                                icon = "assets/svg/radial/megaphone.svg",
                                action = "CreateAdvert"
                            },
                            {
                                name = "FACTURE",
                                icon = "assets/svg/radial/billet.svg",
                                action = "FactureLSFD"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenMainRadialLSFD"
                            },
                            {
                                name = "CERTIFICAT",
                                icon = "assets/svg/radial/health_paper.svg",
                                action = "CertificatLSFD"
                            }
                        }, 
                        title = "PAPIERS",
                        }
                    }));
                end
                
                function OpenSubSoinsRadial()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "REANIMER",
                                icon = "assets/svg/radial/heart.svg",
                                action = "RevivePatientLSFD"
                            },
                            {
                                name = "SOIGNER",
                                icon = "assets/svg/radial/health_tool.svg",
                                action = "HealthPatientLSFD"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenSubRadialActions"
                            },
                        }, 
                        title = "SOINS",
                        }
                    }));
                end

                function OpenSubIncendieRadial()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "LANCE",
                                icon = "assets/svg/radial/fire_extinguisher.svg",
                                action = "ToggleHose"
                            },
                            {
                                name = "MOUSSE",
                                icon = "assets/svg/radial/repair.svg",
                                action = "ToggleFoam"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenSubRadialActions"
                            },
                        }, 
                        title = "INCENDIE",
                        }
                    }));
                end

                function OpenSubRadialObjectLSFD()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "OBJETS",
                                icon = "assets/svg/radial/object.svg",
                                action = "OpenPropsMenuLSFD"
                            },
                            {
                                name = "BRANCARD",
                                icon = "assets/svg/radial/health_tool.svg",
                                action = "Spawnbrancard"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenSubRadialActions"
                            }
                        }, 
                        title = "SOINS",
                        }
                    }));
                end

                function OpenSubRadialActions()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "OBJETS",
                                icon = "assets/svg/radial/object.svg",
                                action = "OpenSubRadialObjectLSFD"
                            },
                            {
                                name = "SOINS",
                                icon = "assets/svg/radial/health_tool.svg",
                                action = "OpenSubSoinsRadial"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenMainRadialLSFD"
                            },
                            {
                                name = "INCENDIE",
                                icon = "assets/svg/radial/fire_station.svg",
                                action = "OpenSubIncendieRadial"
                            }
                        }, 
                        title = "ACTIONS",
                        }
                    }));
                end

                function OpenMainRadialLSFD()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "APPEL DE RENFORT",
                                icon = "assets/svg/radial/fire.svg",
                                action = "makeRenfortCall"
                            }, 
                            {
                                name = "PAPIERS",
                                icon = "assets/svg/radial/paper.svg",
                                action = "OpenSubRadialPapiers"
                            },
                            {
                                name = "PRISE DE SERVICE",
                                icon = "assets/svg/radial/checkmark.svg",
                                action = "lsfdActionDuty"
                            },
                            {
                                name = "ACTIONS",
                                icon = "assets/svg/radial/fire_extinguisher.svg",
                                action = "OpenSubRadialActions"
                            }
                        }, title = "LSFD"}
                    }));
                end

                OpenMainRadialLSFD()
            end)
        else
            openRadial = false
            SetNuiFocusKeepInput(false)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 142, true)
            EnableControlAction(0, 18, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 106, true)
            SetNuiFocus(false, false)
            SendNuiMessage(json.encode({
                type = 'closeWebview'
            }))
            return
        end
    end

    RegisterNUICallback("focusOut", function(data, cb)
        if openRadial then
            openRadial = false
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 142, true)
            EnableControlAction(0, 18, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 106, true)
        end
        cb({})
    end)

    RegisterJobMenu(OpenRadialLSFDMenu)

    function openOutfitMenu()
        if open then
            open = false
            RageUI.Visible(outifitmenu, false)
        else
            open = true
            RageUI.Visible(outifitmenu, true)
            oldSkin = p:skin()
            Citizen.CreateThread(function()
                while open do
                    RageUI.IsVisible(outifitmenu, function()
                        for k, v in pairs(lsfd.outfit) do
                            RageUI.Button(v.name, nil, {}, true, {
                                onSelected = function()
                                    selected_table = v
                                end
                            }, outfitmenu_list)
                        end
                    end)
                    RageUI.IsVisible(outfitmenu_list, function()
                        for k, v in pairs(selected_table) do
                            if k ~= "name" then
                                RageUI.Button(k, nil, {}, true, {
                                    onSelected = function()
                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                            if skin.sex == 0 then
                                                if v.male then
                                                    TriggerSecurGiveEvent("core:addItemToInventory", token, "outfit", 1,
                                                        {
                                                            renamed = k,
                                                            data = v.male
                                                        })
                                                end
                                            else
                                                if v.female then
                                                    TriggerSecurGiveEvent("core:addItemToInventory", token, "outfit", 1,
                                                        {
                                                            renamed = k,
                                                            data = v.female
                                                        })
                                                end
                                            end
                                        end)
                                    end
                                })
                            end
                        end
                    end)
                    Wait(1)
                end
            end)
        end
    end


    local function GetDatasPropsLSFD()
        -- DataSendPropsLSFD.items.elements = {}

        playerJobs = 'lsfd-sams'

        -- Cones
        for i = 1, 7 do
            table.insert(DataSendPropsLSFD.items[2].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Cones/"..i..".webp",
                category="Cones", 
                label = "#"..i
            })
        end


        -- Panneaux
        for i = 1, 5 do
            table.insert(DataSendPropsLSFD.items[3].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Panneaux/"..i..".webp",
                category="Panneaux",
                label = "#"..i
            })
        end

        -- Barrière
        for i = 1, 9 do
            table.insert(DataSendPropsLSFD.items[4].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Barrieres/"..i..".webp",
                category="Barrières",
                label = "#"..i
            })
        end

        -- Lumières
        for i = 1, 5 do
            table.insert(DataSendPropsLSFD.items[5].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Lumieres/"..i..".webp",
                category="Lumières",
                label = "#"..i
            })
        end

        -- Tables
        for i = 1, 2 do
            table.insert(DataSendPropsLSFD.items[6].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Tables/"..i..".webp",
                category="Tables",
                label = "#"..i
            })
        end

        -- Divers
        for i = 1, 7 do
            table.insert(DataSendPropsLSFD.items[7].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Divers/"..i..".webp",
                category="Divers",
                label = "#"..i
            })
        end

        -- Sacs
        for i = 1, 2 do
            table.insert(DataSendPropsLSFD.items[8].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Sacs/"..i..".webp",
                category="Sacs",
                label = "#"..i
            })
        end


        DataSendPropsLSFD.disableSubmit = true

        return true
    end




    RegisterNUICallback("focusOut", function()
        if PropsMenu.open then
            PropsMenu.open = false 
        end
    end)

    DataSendPropsLSFD = {
        items = {
            {   
                name = 'main',
                type = 'buttons',
                elements = {
                    {
                        name = 'Cones',
                        width = 'full',
                        image = 'assets/PropsMenu/cones.svg',
                        hoverStyle = ' stroke-black'
                    },
                    {
                        name = 'Panneaux',
                        width = 'full',
                        image = 'assets/PropsMenu/roadsign.svg',
                        hoverStyle = ' stroke-black'
                    },
                    {
                        name = 'Barrières',
                        width = 'full',
                        image = 'assets/PropsMenu/barriere.svg',
                        hoverStyle = ' stroke-black'
                    },
                    {
                        name = 'Lumières',
                        width = 'full',
                        image = 'assets/PropsMenu/light.svg',
                        hoverStyle = ' stroke-black'
                    },
                    {
                        name = 'Tables',
                        width = 'full',
                        image = 'assets/PropsMenu/table.svg',
                        hoverStyle = ' stroke-black'
                    },
                    {
                        name = 'Divers',
                        width = 'full',
                        image = 'assets/PropsMenu/divers.svg',
                        hoverStyle = ' stroke-black'
                    },
                    {
                        name = 'Sacs',
                        width = 'full',
                        image = 'assets/PropsMenu/sacs.svg',
                        hoverStyle = ' stroke-black'
                    },
                },
            },
            {
                name = 'Cones',
                type = 'elements',
                elements = {},
            },
            {
                name = 'Panneaux',
                type = 'elements',
                elements = {},
            },
            {
                name = 'Barrières',
                type = 'elements',
                elements = {},
            },
            {
                name = 'Lumières',
                type = 'elements',
                elements = {},
            },
            {
                name = 'Tables',
                type = 'elements',
                elements = {},
            },
            {
                name = 'Divers',
                type = 'elements',
                elements = {},
            },
            {
                name = 'Sacs',
                type = 'elements',
                elements = {},
            },
        },


        -- headerIcon = 'assets/icons/market-cart.png',
        -- headerIconName = 'Cones',
        headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSFD/header_lsfd.webp',
        callbackName = 'MenuObjetsServicesPublicsLSFD',
        showTurnAroundButtons = false,
    }

    local firstart = false

    function OpenPropsMenuLSFD()
        if firstart == false then
            firstart = true 
            local bool = GetDatasPropsLSFD()
            while not bool do 
                Wait(1)
            end
        end
        SendNuiMessage(json.encode({
            type = 'closeWebview',
        }))
        Wait(50)
        PropsMenu.open = true
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuObjetsServicesPublics',
            data = DataSendPropsLSFD
        }))
    end


end

function UnloadLsfdJob()
    zone.removeZone("coffre_lsfd")
    zone.removeZone("coffre_lsfd_nord")
    zone.removeZone("lsfdOutfit")
    zone.removeZone("lsfd_garage")
    zone.removeZone("lsfd_garage_nord")
    zone.removeZone("society_lsfd")
    zone.removeZone("society_lsfd_nord")
    zone.removeZone("stockage_lsfd")
    zone.removeZone("stockage_lsfd_nord")
    zone.removeZone("lsfd_armory")
    zone.removeZone("lsfd_armory_nord")
    zone.removeZone("lsfd_garage_vehicle")
    zone.removeZone("lsfd_garage_vehicle_nord")
    zone.removeZone("spawn_lsfd_heli")
    zone.removeZone("spawn_lsfd_heli_nord")
    zone.removeZone("society_lsfdHeli_delete")
    zone.removeZone("spawn_lsfd_boat")
    zone.removeZone("society_lsfdBoat_delete")
    lsfdDuty = false
end

PropsMenu = {
    cam = nil,
    open = false,
}

-- MENU PROPS

local LSFDPropsPlaced = {}

local function SpawnPropsLSFD(obj, name)
    local coords, forward = GetEntityCoords(p:ped()), GetEntityForwardVector(p:ped())
    local objCoords = (coords + forward * 2.5)
    local placed = false
    local heading = p:heading()

    local objS = entity:CreateObject(obj, objCoords)
    objS:setPos(objCoords)
    objS:setHeading(heading)
    PlaceObjectOnGroundProperly(objS.id)

    while not placed do
        coords, forward = GetEntityCoords(p:ped()), GetEntityForwardVector(p:ped())
        objCoords = (coords + forward * 2.5)
        objS:setPos(objCoords)
        PlaceObjectOnGroundProperly(objS.id)
        objS:setAlpha(170)
        SetEntityCollision(objS.id, false, true)

        if IsControlPressed(0, 190) then
            heading = heading + 0.5
        elseif IsControlPressed(0, 189) then
            heading = heading - 0.5
        end

        SetEntityHeading(objS.id, heading)

        ShowHelpNotification(
            "Appuyez sur ~INPUT_CONTEXT~ pour placer l'objet\n~INPUT_FRONTEND_LEFT~ ou ~INPUT_FRONTEND_RIGHT~ Pour faire pivoter l'objet") -- \n ~INPUT_VEH_FLY_DUCK~ Pour annuler
        if IsControlJustPressed(0, 38) then
            placed = true

            OpenPropsMenuLSFD()
        end
        
        Wait(0)
    end
    SetEntityCollision(objS.id, true, true)
    -- SetEntityInvincible(objS.id, true)
    -- objS:setFreeze(true)
    objS:resetAlpha()
    local netId = objS:getNetId()
    if netId == 0 then
        objS:delete()
    end
    SetNetworkIdCanMigrate(netId, true)
    table.insert(LSFDPropsPlaced, {
        nom = name,
        prop = objS.id
    })
end

local cones_models = {
    ['#1']     = "prop_air_conelight",
    ['#2']     = "prop_mp_cone_03",
    ['#3']     = "prop_mp_cone_04",
    ['#4']     = "prop_roadcone02a",
    ['#5']     = "prop_roadcone02b",
    ['#6']     = "prop_roadpole_01a",
    ['#7']     = "prop_roadpole_01b",
}

local panneaux_models = {
    ['#1']     = "prop_consign_01b",
    ['#2']     = "prop_consign_02a",
    ['#3']     = "prop_sign_road_01a",
    ['#4']     = "prop_sign_road_06q",
    ['#5']     = "prop_sign_road_06r",
}

local barriere_models = {
    ['#1']     = "prop_barrier_work01a",
    ['#2']     = "prop_barrier_work01b",
    ['#3']     = "prop_barrier_work02a",
    ['#4']     = "prop_barrier_work05",
    ['#5']     = "prop_barrier_work06a",
    ['#6']     = "prop_barrier_work06b",
    ['#7']     = "prop_fncsec_04a",
    ['#8']     = "prop_mp_arrow_barrier_01",
    ['#9']     = "prop_mp_barrier_02b",
}

local lumiere_models = {
    ['#1']     = "prop_generator_03b",
    ['#2']     = "prop_worklight_01a",
    ['#3']     = "prop_worklight_03b",
    ['#4']     = "prop_worklight_04a",
    ['#5']     = "prop_worklight_04b",
}

local tables_models = {
    ['#1']     = "bkr_prop_weed_table_01b",
    ['#2']     = "prop_ven_market_table1",
}

local divers_models = {
    ['#1']     = "ex_office_swag_med2",
    ['#2']     = "gr_prop_gr_laptop_01c",
    ['#3']     = "prop_gazebo_02",
    ['#4']     = "prop_ld_health_pack",
    ['#5']     = "sm_prop_smug_crate_m_medical",
    ['#6']     = "xm_prop_body_bag",
    ['#7']     = "xm_prop_smug_crate_s_medical",
}

local sacs_models = {
    ['#1']     = "xm_prop_x17_bag_01c",
    ['#2']     = "xm_prop_x17_bag_med_01a",
}


RegisterNUICallback("MenuObjetsServicesPublicsLSFD", function(data, cb)
    -- if data == nil or data.category == nil then return end
    -- PropsMenu.choice = data.category

    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))

    if data.category == "Cones" then 
        print(data.label)
        
        SpawnPropsLSFD(cones_models[data.label], data.label)
    end
    
    if data.category == "Panneaux" then 
        print(data.label)
    
        SpawnPropsLSFD(panneaux_models[data.label], data.label)
    end

    if data.category == "Barrières" then 
        print(data.label)

        SpawnPropsLSFD(barriere_models[data.label], data.label)
    end

    if data.category == "Lumières" then 
        print(data.label)

        SpawnPropsLSFD(lumiere_models[data.label], data.label)
    end

    if data.category == "Tables" then 
        print(data.label)

        
        SpawnPropsLSFD(tables_models[data.label], data.label)
    end

    if data.category == "Divers" then 
        print(data.label)

        
        SpawnPropsLSFD(divers_models[data.label], data.label)
    end

    if data.category == "Sacs" then 
        print(data.label)

        
        SpawnPropsLSFD(sacs_models[data.label], data.label)
    end

end)


local pos = {  
    vector4(-1659.53, 44.39, 64, 142.08),
    }

RegisterNUICallback("Menu_LSFD_vehicule_callback", function(data, cb)
    local distancenord = GetDistanceBetweenCoords(2534.9548339844, 4227.45703125, 39.393028259277, GetEntityCoords(PlayerPedId()))
    if distancenord < 50.0 then
        if vehicle.IsSpawnPointClear(vector3(2537.16015625, 4227.888671875, 39.43293762207), 3.0) then
            vehs = vehicle.create(data.spawnName, vector4(2537.16015625, 4227.888671875, 39.43293762207, 253.84143066406), {})
            SetVehicleMod(vehs, 11, 1, false)
            SetVehicleMod(vehs, 12, 1, false)
            SetVehicleMod(vehs, 13, 1, false)
            if data.spawnName == 'samscara' then
                SetVehicleLivery(vehs, 2)
            elseif data.label == 'Stalker FM LSFD' then
                SetVehicleLivery(vehs, 3)
            elseif data.label == 'Stalker LSFD' then
                SetVehicleLivery(vehs, 2)  
            elseif data.spawnName == 'ems2stx' then
                SetVehicleLivery(vehs, 0)
            elseif data.spawnName == 'mocpacker' then
                SetVehicleLivery(vehs, 4)  
            end
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
            SendNuiMessage(json.encode({
                type = 'closeWebview',
            }))
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Il n'y a ~s pas de place ~c pour le véhicule"
            })
        end
    else
        if vehicle.IsSpawnPointClear(vector3(1196.6014404297, -1455.1939697266, 33.977867126465), 3.0) then
            vehs = vehicle.create(data.spawnName, vector4(1196.6014404297, -1455.1939697266, 33.977867126465, 359.69262695313), {})
            SetVehicleMod(vehs, 11, 1, false)
            SetVehicleMod(vehs, 12, 1, false)
            SetVehicleMod(vehs, 13, 1, false)
            if data.spawnName == 'samscara' then
                SetVehicleLivery(vehs, 2)
            elseif data.label == 'Stalker FM LSFD' then
                SetVehicleLivery(vehs, 3)
            elseif data.label == 'Stalker LSFD' then
                SetVehicleLivery(vehs, 2)  
            elseif data.spawnName == 'ems2stx' then
                SetVehicleLivery(vehs, 0) 
            end
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
            SendNuiMessage(json.encode({
                type = 'closeWebview',
            }))
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Il n'y a ~s pas de place ~c pour le véhicule"
            })
        end
    end
end)

RegisterNUICallback("Menu_LSFD_heli_callback", function (data, cb)
    local distancenord2 = GetDistanceBetweenCoords(2486.9665527344, 4264.3823242188, 38.096633911133, GetEntityCoords(PlayerPedId()))
    if distancenord2 < 50.0 then
        if vehicle.IsSpawnPointClear(vector3(2486.9665527344, 4264.3823242188, 38.096633911133), 3.0) then
            vehs = vehicle.create(data.spawnName, vector4(2486.9665527344, 4264.3823242188, 38.096633911133, 195.3282623291), {})
            -- SetVehicleLivery(vehs, 0)
            if data.spawnName == 'AS332' then
                SetVehicleLivery(vehs, 2)
            else
                SetVehicleLivery(vehs, 2)
            end
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)  
            SendNuiMessage(json.encode({
                type = 'closeWebview',
            }))
        else
            -- ShowNotification("Il n'y a pas de place pour le véhicule")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Il n'y a ~s pas de place ~c pour le véhicule"
            })
        end
    else
        if vehicle.IsSpawnPointClear(vector3(-745.3798, -1468.5571, 5.0005), 3.0) then
            vehs = vehicle.create(data.spawnName, vector4(-745.3798, -1468.5571, 5.0005, 320.1437), {})
            -- SetVehicleLivery(vehs, 0)
            if data.spawnName == 'AS332' then
                SetVehicleLivery(vehs, 2)
            else
                SetVehicleLivery(vehs, 2)
            end
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
            SendNuiMessage(json.encode({
                type = 'closeWebview',
            }))
        else
            -- ShowNotification("Il n'y a pas de place pour le véhicule")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Il n'y a ~s pas de place ~c pour le véhicule"
            })
        end
    end
end)

RegisterNUICallback("Menu_LSFD_boat_callback", function (data, cb)
    if vehicle.IsSpawnPointClear(vector3(-801.99151611328, -1500.0753173828, -0.47385582327843), 3.0) then
        vehs = vehicle.create(data.spawnName, vector4(-801.99151611328, -1500.0753173828, -0.47385582327843, 108.33866882324), {})
        if data.spawnName == 'emsseashark' then
            SetVehicleLivery(vehs, 1)
        elseif data.spawnName == 'poldinghy' then
            SetVehicleLivery(vehs, 2)
        end
        local plate = vehicle.getProps(vehs).plate
        local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
        local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
        createKeys(plate, model)
        SendNuiMessage(json.encode({
            type = 'closeWebview',
        }))
    else
        -- ShowNotification("Il n'y a pas de place pour le véhicule")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "Il n'y a ~s pas de place ~c pour le véhicule"
        })
    end
end)

RegisterNUICallback("armoryTakeLSFD", function(data, cb)
    for k, v in pairs(data) do
        TriggerSecurGiveEvent("core:addItemToInventory", token, v.name, 1, {})
        exports['vNotif']:createNotification({
            type = 'DOLLAR',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous venez de récupérer ~s un(e) ".. v.label
        })
    end
    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
end)