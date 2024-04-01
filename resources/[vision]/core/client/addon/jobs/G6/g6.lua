local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

CreateThread(function()
    while zone == nil do Wait(1)end

    local ped2 = entity:CreatePedLocal("s_m_m_armoured_02", vector3(2.9961116313934, -713.00762939453, 31.480628967285), 333.05)
    ped2:setFreeze(true)
    SetEntityInvincible(ped2.id, true)
    SetEntityAsMissionEntity(ped2.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped2.id, true)
end)


g6Duty = false
function LoadG6()

    zone.addZone("g6_item", vector3(2525.1440429688, -298.29415893555,-58.722972869873),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir l'armurerie", 
        function()
            OpenG6ITEMMenu()
        end,
        false, -- Avoir un marker ou non
        -1, -- Id / type du marker
        0.6, -- La taille
        { 0, 0, 0 }, -- RGB
        0, -- Alpha
        2.5 -- Interact dist
    )

    local items = {
        headerImage = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Banners/G6.webp",
        headerIcon = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Banners/icon.webp',
        headerIconName = 'CATALOGUE',
        callbackName = 'armoryTake',
        showTurnAroundButtons = false,
        multipleSelection = true,
        elements = {
            {
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Boite_cartouches.webp",
                price = 0,
                id = 1,
                name = "ammo30",
                label = "Boite de cartouches",
            },
            {
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Extincteur.webp",
                price = 0,
                id = 2,
                name = "weapon_fireextinguisher",
                label = "Extincteur",
            },
            {
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Gaz_bz.webp",
                price = 0,
                id = 3,
                name = "weapon_bzgas",
                label = "GAZ BZ",
            },
            {
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Kevlar_leger.webp",
                price = 0,
                id = 4,
                name = "kevlarle",
                label = "Gilet de kevlar léger",
            },
            {
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Kevlar_lourd.webp",
                price = 0,
                id = 5,
                name = "kevlarlo",
                label = "Gilet de kevlar lourd",
            },
            {
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Kevlar_moyen.webp",
                price = 0,
                id = 6,
                name = "kevlarm",
                label = "Gilet de kevlar moyen",
            },
            {
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Lampe_torche.webp",
                price = 0,
                id = 7,
                name = "weapon_flashlight",
                label = "Lampe torche",
            },
            {
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Matraque.webp",
                price = 0,
                id = 8,
                name = "weapon_nightstick",
                label = "Matraque",
            },
            {
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Radio.webp",
                price = 0,
                id = 9,
                name = "radio",
                label = "Radio",
            },
        }
    }

    function OpenG6ITEMMenu()
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

    RegisterNUICallback("armoryTake", function(data, cb)
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

    Keys.Register("F2", "F2", "Faire un appel de renfort", function()
        makeRenfortCallG6()
    end)
    function makeRenfortCallG6()
        if g6Duty then
            TriggerServerEvent('core:makeCall', "g6", p:pos(), false, "appel de renfort")
        else
            -- ShowNotification("~r~Vous n'êtes pas en service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous n'êtes ~s pas en service"
            })
        end
    end

    local openRadial = false
    function OpenRadialG6Menu()
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
            Wait(200)
            CreateThread(function()
                SendNuiMessage(json.encode({
                    type = 'openWebview',
                    name = 'RadialMenu',
                    data = { elements = {
                        {
                            name = "Service",
                            icon = "assets/RadialMenus/check.svg",
                            action = "SetG6Duty"
                        },
                        {
                            name = "Renforts",
                            icon = "assets/RadialMenus/lspdblanc.svg",
                            action = "makeRenfortCallG6"
                        },
                        {
                            name = "Objets",
                            job = "police",
                            icon = "assets/RadialMenus/barriere-routiere.svg",
                            action = "openG6PropsMenu"
                        },
                        {
                            name = "Circulation",
                            job = "police",
                            icon = "assets/RadialMenus/circulationblanc.svg",
                            action = "openTraficMenu"
                        }
                    }, title = "Menu G6"
                    }
                }));
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

    local open = false
    local g6menu_objects = RageUI.CreateMenu("", "G6", 0.0, 0.0, "vision", "menu_title_g6")
    local g6menu_traffic = RageUI.CreateMenu("", "G6", 0.0, 0.0, "vision", "menu_title_g6")
    local g6menu_traffic_view = RageUI.CreateSubMenu(g6menu_traffic, "", "G6", 0.0, 0.0, "vision",
        "menu_title_g6")
    local g6menu_traffic_add = RageUI.CreateSubMenu(g6menu_traffic, "", "G6", 0.0, 0.0, "vision",
        "menu_title_g6")
    local g6menu_objects_delete = RageUI.CreateSubMenu(g6menu_objects, "", "G6", 0.0, 0.0, "vision",
        "menu_title_g6")
        g6menu_objects.Closed = function()
        open = false
    end
    g6menu_traffic.Closed = function()
        open = false
        speed = 0.0
        radius = 0.0
        show = false
        zoneName = ""
    end

    local policePropsPlaced = {}
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
        table.insert(policePropsPlaced, {
            nom = name,
            prop = objS.id
        })
    end

    function openG6PropsMenu()
        if g6Duty then
            if open then
                open = false
                RageUI.Visible(g6menu_objects, false)
            else
                open = true
                RageUI.Visible(g6menu_objects, true)

                Citizen.CreateThread(function()
                    while open do
                        RageUI.IsVisible(g6menu_objects, function()
                            RageUI.Button("Supprimer mes props", nil, {}, true, {}, g6menu_objects_delete)
                            for k, v in pairs(police.props) do
                                RageUI.Button(v.nom, nil, {}, true, {
                                    onSelected = function()
                                        SpawnObject(v.prop, v.nom)
                                    end
                                })
                            end
                        end)
                        RageUI.IsVisible(g6menu_objects_delete, function()
                            for k, v in pairs(policePropsPlaced) do
                                RageUI.Button(v.nom, nil, {}, true, {
                                    onSelected = function()
                                        DeleteObject(v.prop)
                                        table.remove(policePropsPlaced, k)
                                    end,
                                    onActive = function()
                                        DrawMarker(20, GetEntityCoords(v.prop) + vector3(0.0, 0.0, 1.0), 0.0, 0.0, 0.0,
                                            180.0, 0.0, 0.0, 0.5, 0.5, 0.5, 92, 173, 29, 255, true, 1, 0, 0)
                                    end
                                })
                            end
                        end)
                        Wait(1)
                    end
                end)
            end
        else
            -- ShowNotification("~r~Vous n'êtes pas en service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous n'êtes ~s pas en service"
            })
        end
    end

    
    local traficList = {}
    local speed = 0.0
    local radius = 0.0
    local show = false
    local zoneName = ""
    local zonePos = vector3(0, 0, 0)

    function openTraficMenu()
        if g6Duty then
            -- open a menu with 2 buttons : one to add a new zone and one to view my zones
            if open then
                open = false
                RageUI.Visible(g6menu_traffic, false)
            else
                open = true
                RageUI.Visible(g6menu_traffic, true)

                Citizen.CreateThread(function()
                    while open do
                        RageUI.IsVisible(g6menu_traffic, function()
                            -- for the first button to add a new zone, it opens a menu where i can set the speed in the zone and the radius of the zone, another checkbox to show it on my client and a last button to add the zone
                            RageUI.Button("Ajouter une zone", nil, { RightLabel = ">" }, true, {
                                onSelected = function()
                                    zonePos = p:pos()
                                end
                            }, g6menu_traffic_add)
                            -- for the second button to view my zones, it opens a menu where i can see all my zones and delete them
                            RageUI.Button("Voir les zones", nil, { RightLabel = ">" }, true, {
                                onSelected = function()
                                    traficList = TriggerServerCallback("lspd:traffic:get")
                                end
                            }, g6menu_traffic_view)
                        end)
                        RageUI.IsVisible(g6menu_traffic_add, function()
                            -- for the speed and radius button, prompt a keyboard to enter the value
                            RageUI.Button("Vitesse", nil, { RightLabel = speed .. " km/h" }, true, {
                                onSelected = function()
                                    speed = tonumber(KeyboardImput("Vitesse")) + .0
                                    if speed == nil then
                                        speed = 0.0
                                    end
                                end
                            })
                            RageUI.Button("Rayon", nil, { RightLabel = radius .. " m" }, true, {
                                onSelected = function()
                                    radius = tonumber(KeyboardImput("Rayon")) + .0
                                    if radius == nil then
                                        radius = 0.0
                                    end
                                end
                            })
                            RageUI.Checkbox("Afficher", nil, show, {}, {
                                onChecked = function()
                                    show = true
                                end,
                                onUnChecked = function()
                                    show = false
                                end
                            })
                            RageUI.Button("Nom de la zone", nil, { RightLabel = zoneName }, true, {
                                onSelected = function()
                                    zoneName = KeyboardImput("Nom de la zone")
                                end
                            })
                            RageUI.Button("Ajouter la zone", nil, {}, true, {
                                onSelected = function()
                                    if radius ~= 0 and zoneName ~= "" then
                                        local id = AddRoadNodeSpeedZone(zonePos, radius, speed, true)
                                        local newZone = {
                                            zoneName = zoneName,
                                            zonePos = zonePos,
                                            zoneRadius = radius,
                                            zoneSpeed = speed,
                                            zoneId = id 
                                        }
                                        show = false
                                        TriggerServerEvent("lspd:traffic:add", newZone)
                                        -- ShowNotification("~g~Zone ajoutée")

                                        -- New notif
                                        exports['vNotif']:createNotification({
                                            type = 'VERT',
                                            -- duration = 5, -- In seconds, default:  4
                                            content = "~s Zone ajoutée"
                                        })

                                        open = false
                                        RageUI.CloseAll()
                                    else
                                        -- ShowNotification("~r~Veuillez remplir tous les champs")

                                        -- New notif
                                        exports['vNotif']:createNotification({
                                            type = 'ROUGE',
                                            -- duration = 5, -- In seconds, default:  4
                                            content = "~s Veuillez remplir tous les champs"
                                        })

                                    end
                                end
                            })
                        end)
                        RageUI.IsVisible(g6menu_traffic_view, function()
                            for k, v in pairs(traficList) do
                                RageUI.Button(v.zoneId .. " | " .. v.zoneName, nil, { RightLabel = "~r~ Supprimer" }, true,
                                    {
                                        onSelected = function()
                                            RemoveRoadNodeSpeedZone(v.zoneId)
                                            TriggerServerEvent("lspd:traffic:remove", v.zoneId)
                                            -- ShowNotification("~r~Zone supprimée")

                                            -- New notif
                                            exports['vNotif']:createNotification({
                                                type = 'VERT',
                                                -- duration = 5, -- In seconds, default:  4
                                                content = "~s Zone supprimée"
                                            })
                                            
                                            RageUI.GoBack()
                                        end,
                                        onActive = function()
                                            local distance = v.zoneRadius + .0
                                            DrawMarker(1, v.zonePos + vector3(0.0, 0.0, -1000.0), 0.0, 0.0, 0.0, 0.0, 0.0, .0
                                                , distance + .0, distance + .0, 10000.0, 20, 192, 255, 70, 0, 0, 2
                                                , 0, 0, 0, 0)
                                        end
                                    })
                            end
                        end)
                        if show then
                            -- draw circle around player with the radius of the zone
                            local distance = radius + .0
                            DrawMarker(1, p:pos() + vector3(0.0, 0.0, -1000.0), 0.0, 0.0, 0.0, 0.0, 0.0, .0, distance + .0,
                                distance + .0, 10000.0, 20, 192, 255, 70, 0, 0, 2, 0, 0, 0, 0)
                        end
                        Wait(1)
                    end
                end)
            end
        else
            -- ShowNotification("~r~Vous n'êtes pas en service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous n'êtes ~s pas en service"
            })

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
    function SetG6Duty()
        if g6Duty then
            TriggerServerEvent('core:DutyOff', 'g6')
            -- ShowNotification("Vous avez ~r~quitté~s~ votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s quitté ~c votre service"
            })

            g6Duty = false
            Wait(5000)
        else
            TriggerServerEvent('core:DutyOn', 'g6')
            -- ShowNotification("Vous avez ~g~pris~s~ votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s pris ~c votre service"
            })

            g6Duty = true
            Wait(5000)
        end
    end

    RegisterJobMenu(OpenRadialG6Menu)

    local g6Veh = {
        headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_g6.webp',
        headerIcon = 'assets/icons/voiture-icon.png',
        headerIconName = 'VEHICULES',
        callbackName = 'G6Menu',
        elements = {
            {
                id = 1,
                image = 'assets/G6/vehicles/g6alamo4.png',
                label = 'Alamo G6',
                name = "g6alamo4"
            },
            {
                id = 2,
                image = 'assets/G6/vehicles/g6bison2.png',
                label = 'Bison G6',
                name = "g6bison2"
            },
            {
                id = 3,
                image = 'assets/G6/vehicles/g6buffalo2.png',
                label = 'Bufallo G6',
                name = "g6buffalo2"
            },
            {
                id = 4,
                image = 'assets/G6/vehicles/g6fugitive.png',
                label = 'Fugitive G6',
                name = "g6fugitive"
            },
            {
                id = 5,
                image = 'assets/G6/vehicles/g6scout2.png',
                label = 'Scout G6',
                name = "g6scout2"
            },
            {
                id = 6,
                image = 'assets/G6/vehicles/g6scout3.png',
                label = 'Scout G6',
                name = "g6scout3"
            },
            {
                id = 8,
                image = 'assets/G6/vehicles/g6torrence.png',
                label = 'Torrence G6',
                name = "g6torrence"
            },
            {
                id = 9,
                image = 'assets/G6/vehicles/g6torrence2.png',
                label = 'Torrence G6',
                name = "g6torrence2"
            },
        }
    }

    function OpenMenuVehG6()
            forceHideRadar()
            SendNuiMessage(json.encode({
                type = 'openWebview',
                name = 'MenuCatalogue',
                data = g6Veh
            }))
        end

    RegisterNUICallback("focusOut", function (data, cb)
        TriggerScreenblurFadeOut(0.5)
        DisplayHud(true)
        openRadarProperly()
    end)

    local spawned = false
    RegisterNUICallback("G6Menu", function (data, cb)
        if not spawned then
            spawned = true
            if vehicle.IsSpawnPointClear(vector3(-1.4261150360107, -703.96655273438, 32.338104248047), 3.0) then
                if DoesEntityExist(vehs) then
                    TriggerEvent('persistent-vehicles/forget-vehicle', vehs)
                    removeKeys(GetVehicleNumberPlateText(vehs), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs))))
                    TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(vehs))
                    DeleteEntity(vehs)
                end
                vehs = vehicle.create(data.name, vector4(-1.4261150360107, -703.96655273438, 32.338104248047, 344.89443969727), {})
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
            Wait(50)
            spawned = false
        end
    end)

    zone.addZone("G6_spawn", vector3(2.9961116313934, -713.00762939453, 32.480628967285),
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir", function()
            OpenMenuVehG6()
        end, false, 27, 0.7, { 17, 201, 198 }, 255)

    zone.addZone("G6_delete", vector3(-1.4261150360107, -703.96655273438, 32.338104248047),
        "Appuyer sur ~INPUT_CONTEXT~ pour ranger le véhicule", function()
            if IsPedInAnyVehicle(p:ped(), false) then
                local veh = GetVehiclePedIsIn(p:ped(), false)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                DeleteEntity(veh)

            end
        end, true, 36, 0.5, { 255, 0, 0 }, 255
    )

    zone.addZone("society_G6", vector3(2521.4182128906, -297.23306274414, -58.722980499268),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le coffre de l'entreprise", function()
            OpenSocietyMenu()
        end, true, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone("coffre_G6", vector3(2491.3708496094, -252.45402526855, -55.113815307617),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les actions d'entreprise", function()
            OpenInventorySocietyMenu()
        end, true, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone("G6Outfit", vector3(2527.7145996094, -298.22009277344, -58.722965240479),
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir", function()
            openOutfitMenuG6()
        end, true, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )


    local oldSkin = {}
    local open = false
    local outfitmenu = RageUI.CreateMenu("", "G6", 0.0, 0.0, "vision", "menu_title_g6")
    local outfitmenu_list = RageUI.CreateSubMenu(outfitmenu, "", "G6", 0.0, 0.0, "vision", "menu_title_g6")
    outfitmenu.Closed = function()
        local playerSkin = p:skin()
        ApplySkin(oldSkin)
        open = false
    end

    local selected_table = {}

    function openOutfitMenuG6()
        if open then
            open = false
            RageUI.Visible(outfitmenu, false)
        else
            open = true
            RageUI.Visible(outfitmenu, true)
            oldSkin = p:skin()
            Citizen.CreateThread(function()
                while open do
                    RageUI.IsVisible(outfitmenu, function()
                        for k, v in pairs(usms.outfit) do
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
                                            print(skin.sex)
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

    function FactureG6(entity)
        local billing_price = 0
        local billing_reason = ""
        local player = NetworkGetPlayerIndexFromPed(entity)
        local sID = GetPlayerServerId(player)
        local price = KeyboardImput("Entrez le prix")
        if price and type(tonumber(price)) == "number" then
            billing_price = tonumber(price)
        else

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Veuillez entrer un nombre"
            })

        end
        local reason = KeyboardImput("Entrez la raison")
        if reason ~= nil then
            billing_reason = tostring(reason)
        end

        if entity == nil then
            local closestPlayer, closestDistance = GetClosestPlayer()
            if closestPlayer ~= nil and closestDistance < 3.0 then
                TriggerServerEvent('core:sendbilling', token, GetPlayerServerId(closestPlayer), p:getJob(),
                    billing_price, billing_reason)
            else

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Aucun joueur dans la zone"
                })

            end
        else
            TriggerServerEvent('core:sendbilling', token, sID, p:getJob(), billing_price, billing_reason)

            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "Facturation envoyée \nPrix : ~s " .. billing_price .. "$ \n~c Raison : ~s " .. billing_reason
            })
        end
    end

    --car teleporter
    zone.addZone(
        "enter_g6",
        vector3(19.392213821411, -679.85491943359, 31.338088989258),
        "Appuyez sur ~INPUT_CONTEXT~ pour entrer",
        function()
            enterG6()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    zone.addZone(
        "leave_g6",
        vector3(2648.9147949219, -338.23779296875, -65.722557067871),
        "Appuyez sur ~INPUT_CONTEXT~ pour sortir",
        function()
            LeaveG6()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    function enterG6()
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Wait(0)
        end        
        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Wait(1) end
        SetPedCoordsKeepVehicle(p:ped(), 2648.9147949219, -338.23779296875, -63.722557067871)
        SetEntityHeading(p:currentVeh(), 47.33224105835)
        DoScreenFadeIn(800)
    end

    function LeaveG6()
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Wait(0)
        end
        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Wait(1) end
        SetPedCoordsKeepVehicle(p:ped(), 19.392213821411, -679.85491943359, 31.338088989258)
        SetEntityHeading(p:currentVeh(), 152.90191650391)
            
        DoScreenFadeIn(800)
    end

    -- bank teleporter
    zone.addZone(
        "enterBank_g6",
        vector3(2465.37890625, -279.18856811523, -70.694221496582),
        "Appuyez sur ~INPUT_CONTEXT~ pour entrer",
        function()
            enterBankG6()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    zone.addZone(
        "leaveBank_g6",
        vector3(2493.3452148438, -238.44473266602, -70.742111206055),
        "Appuyez sur ~INPUT_CONTEXT~ pour sortir",
        function()
            LeaveBankG6()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    function enterBankG6()
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Wait(0)
        end        
        SetEntityCoords(p:ped(), vector3(2493.3452148438, -238.44473266602, -70.742111206055), false, false, false, true)
        Wait(50)
        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Wait(1) end
        SetEntityCoords(p:ped(), vector3(2493.3452148438, -238.44473266602, -70.742111206055), false, false, false, true)

        DoScreenFadeIn(800)
    end

    function LeaveBankG6()
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Wait(0)
        end
        SetEntityCoords(p:ped(), vector3(2465.37890625, -279.18856811523, -70.694221496582), false, false, false, true)
        Wait(50)
        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Wait(1) end
        SetEntityCoords(p:ped(), vector3(2465.37890625, -279.18856811523, -70.694221496582), false, false, false, true)
        DoScreenFadeIn(800)
    end
end
function PlacePlayerIntoVehicleForG6(entity)
    if g6Duty then
        local players = NetworkGetPlayerIndexFromPed(entity)
        local sID = GetPlayerServerId(players)

        if entity == nil then
            local player, dst = GetClosestPlayer()
            local vehicle = GetClosestVehicle(p:pos())
            if not IsPedInVehicle(player, vehicle, true) then
                TriggerServerEvent("core:PutPlayerIntoVehicle", token, GetPlayerServerId(player), VehToNet(vehicle))
            else
                TriggerServerEvent("core:MakePlayerLeaveVehicle", token, GetPlayerServerId(player))
            end
        else
            local vehicle = GetClosestVehicle(p:pos())
            local pPed = GetPlayerPed(sID)
            if not IsPedInVehicle(pPed, vehicle, true) then
                TriggerServerEvent("core:PutPlayerIntoVehicle", token, tonumber(sID), vehicle)
            else
                TriggerServerEvent("core:MakePlayerLeaveVehicle", token, tonumber(sID))
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

 local coffrePos = { vector3(2520.9309082031, -299.69259643555, -58.722965240479) }

 for k, v in pairs(coffrePos) do
     zone.addZone("casier_g6" .. k, v, "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les casiers",
         function()
             if g6Duty then
                 OpenG6Casier() -- TODO: fini le menu society
             else
                -- ShowNotification("~r~Vous n'êtes pas en service")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous n'êtes ~s pas en service"
                })

             end
         end, false, 25, -- Id / type du marker
         0.6, -- La taille
         { 51, 204, 255 }, -- RGB
         170-- Alpha
     )
 end

 local casierOpen = false
 function OpenG6Casier()
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
                     count = 60
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
     TriggerScreenblurFadeOut(0.5)
     DisplayHud(true)
     openRadarProperly()
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
 end)