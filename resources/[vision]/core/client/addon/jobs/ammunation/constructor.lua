local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

function LoadAmmunation()
    if p:getJob() ~= "ammunation" then
        return
    end
    local inService = false
    local openRadial = false
    local garageMenuPos = vector3(-4.71303, -1108.3901, 26.99)

    local listVeh = {
        headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_ammu.webp',
        headerIcon = 'assets/icons/voiture-icon.png',
        headerIconName = 'VEHICULES',
        callbackName = 'vehMenuAmmu',
        elements = {
            {
                id = 1,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Ammunation/boxville7.webp',
                label = 'Boxville',
                name = "boxville7"
            },
            {
                id = 2,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Ammunation/nspeedo.webp',
                label = 'Speedo',
                name = "nspeedo"
            },
            {
                id = 3,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Ammunation/pounder3.webp',
                label = 'Pounder',
                name = "pounder3"
            },
        }
    }
        
    zone.addZone(
        "ammunation_delete", vector3(-8.7288, -1113.729, 28.37), "Appuyer sur ~INPUT_CONTEXT~ pour ranger le véhicule",
        function()
            if IsPedInAnyVehicle(p:ped(), false) then
                if GetVehicleBodyHealth(p:currentVeh()) / 10 >= 80 or
                    GetVehicleEngineHealth(p:currentVeh()) / 10 >= 80 then
                    local veh = GetVehiclePedIsIn(p:ped(), false)
                    removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                    TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                    TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                    DeleteEntity(veh)
                else
                    -- ShowNotification("~r~Votre véhicule est trop abimé")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Votre véhicule est ~s trop abimé"
                    })

                end
            end
        end,
        true,
        36, 0.5, { 255, 0, 0 }, 255
    )

    zone.addZone(
        "ammunation_delete2", vector3(1700.4677734375, 3769.0673828125, 34.488582611084), "Appuyer sur ~INPUT_CONTEXT~ pour ranger le véhicule",
        function()
            if IsPedInAnyVehicle(p:ped(), false) then
                if GetVehicleBodyHealth(p:currentVeh()) / 10 >= 80 or
                    GetVehicleEngineHealth(p:currentVeh()) / 10 >= 80 then
                    local veh = GetVehiclePedIsIn(p:ped(), false)
                    removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                    TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                    TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                    DeleteEntity(veh)
                else
                    -- ShowNotification("~r~Votre véhicule est trop abimé")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Votre véhicule est ~s trop abimé"
                    })

                end
            end
        end,
        true,
        36, 0.5, { 255, 0, 0 }, 255
    )

    --for k, v in pairs(7.9147367477417, -1100.0101318359, 30.126882553101) do
        zone.addZone(
            "casier_ammu",
            vector3(4.8733153343201, -1109.3458251953, 28.797222137451),
            "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les casiers",
            function()
                OpenAmmuCasier() --TODO: fini le menu society
            end,
            false,
            25, -- Id / type du marker
            0.6, -- La taille
            { 51, 204, 255 }, -- RGB
            170-- Alpha
        )
    --end
    local casierOpen = false
    function OpenAmmuCasier()
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
                        count = 60,
                    },
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
                type = 'closeWebview',
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

    local pos = {
        {
            name = "Coffre_"..p:getJob(), pos = vector3(6.4345, -1099.2067, 29.37),
            action = function()
                if inService then
                    OpenInventorySocietyMenu()
                else
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        content = "Vous n'êtes ~s pas en service"
                    }) 
                end
            end
        },
        {
            name = "CoffreNord_"..p:getJob(), pos = vector3(1697.0106201172, 3759.8994140625, 33.705326080322),
            action = function()
                if inService then
                    OpenInventorySocietyMenu()
                else
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        content = "Vous n'êtes ~s pas en service"
                    }) 
                end
            end
        },
        { name = "menuVeh_" .. p:getJob(), pos = vector3(-4.71303, -1108.3901, 27.99),
            action = function()
                if inService then
                    OpenMenuVehAmmu()
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
        },
        { name = "menuVehNord_" .. p:getJob(), pos = vector3(1702.7169189453, 3755.5949707031, 33.339622497559),
            action = function()
                if inService then
                    OpenMenuVehAmmu()
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
        },
        {
            name = "Gestion_"..p:getJob(), pos = vec3(0,0,0),
            action = function()
                if inService then
                    OpenSocietyMenu()
                else
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        content = "Vous n'êtes ~s pas en service"
                    }) 
                end
            end 
        },
    }

    for key, v in pairs(pos) do
        zone.addZone(
            v.name,
            v.pos.xyz,
            "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
            function()
                v.action()
            end,
            true,
            25, -- Id / type du marker
            0.6, -- La taille
            { 51, 204, 255 }, -- RGB
            170-- Alpha
        )
    end

    function OpenMenuVehAmmu()
        forceHideRadar()
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogue',
            data = listVeh
        }))
    end

    function FactureAmmunation()
        if inService then
            openRadial = false
            closeUI()
            TriggerEvent("nuiPapier:client:startCreation", 2)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function SetAmmunationDuty()
        openRadial = false
        closeUI()
        if not inService then
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez ~s pris ~c votre service"
            })

            TriggerServerEvent('core:DutyOn', "ammunation")
            inService = true
            Wait(5000)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous avez ~s quitté ~c votre service"
            })

            TriggerServerEvent('core:DutyOff', "ammunation")
            inService = false
            Wait(5000)
        end
    end

    function CreateAdvert()
        if inService then
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

    function ContratAmmunation()
        if inService then
            openRadial = false
            closeUI()
            TriggerEvent("nuiPapier:client:startCreation", 3)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end
    
    function OpenRadialAmmunation()
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
                            name = "ANNONCE",
                            icon = "assets/svg/radial/megaphone.svg",
                            action = "CreateAdvert"
                        }, 
                        {
                            name = "FACTURE",
                            icon = "assets/svg/radial/billet.svg",
                            action = "FactureAmmunation"
                        },
                        {
                            name = "PRISE DE SERVICE",
                            icon = "assets/svg/radial/checkmark.svg",
                            action = "SetAmmunationDuty"
                        },
                        {
                            name = "CONTRAT",
                            icon = "assets/svg/radial/paper.svg",
                            action = "ContratAmmunation"
                        }
                    }, title = "AMMUNATION" }
                }));
            end)
        else
            openRadial = false
            closeUI()
            return
        end
    end

    RegisterJobMenu(OpenRadialAmmunation)

    function UnLoadAmmunation()
        for key, v in pairs(pos) do
            zone.removeZone(v.name)
        end
        zone.removeZone(p:getJob().."_delete")
        zone.removeZone("casier_ammu")
    end
end

RegisterNUICallback("vehMenuAmmu", function (data, cb)
    local distancenord = GetDistanceBetweenCoords(1715.1501464844, 3760.2458496094, 33.167037963867, GetEntityCoords(PlayerPedId()))
    if distancenord < 50.0 then
        if vehicle.IsSpawnPointClear(vector3(1715.1501464844, 3760.2458496094, 33.167037963867), 3.0) then
            --RageUI.CloseAll()
            if DoesEntityExist(vehs) then
                TriggerEvent('persistent-vehicles/forget-vehicle', vehs)
                removeKeys(GetVehicleNumberPlateText(vehs), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(vehs))
                DeleteEntity(vehs)
            end
            vehs = vehicle.create(data.name, vector4(1715.1501464844, 3760.2458496094, 33.167037963867, 208.44120788574), {})
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
            if data.name == "nspeedo" then
                SetVehicleLivery(vehs, 1)
                SetVehicleMod(vehs, 48, 1)
            elseif data.name == "boxville7" then
                SetVehicleLivery(vehs, 0)
                SetVehicleMod(vehs, 48, 0)
            elseif data.name == "pounder3" then
                SetVehicleLivery(vehs, 1)
                SetVehicleMod(vehs, 48, 1)
            end
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
        if vehicle.IsSpawnPointClear(vector3(-8.7288, -1113.729, 28.39), 3.0) then
            --RageUI.CloseAll()
            if DoesEntityExist(vehs) then
                TriggerEvent('persistent-vehicles/forget-vehicle', vehs)
                removeKeys(GetVehicleNumberPlateText(vehs), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(vehs))
                DeleteEntity(vehs)
            end
            vehs = vehicle.create(data.name, vector4(-9.4610471725464, -1115.3248291016, 27.176298141479, 162.42535400391), {})
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
            if data.name == "nspeedo" then
                SetVehicleLivery(vehs, 1)
                SetVehicleMod(vehs, 48, 1)
            elseif data.name == "boxville7" then
                SetVehicleLivery(vehs, 0)
                SetVehicleMod(vehs, 48, 0)
            elseif data.name == "pounder3" then
                SetVehicleLivery(vehs, 1)
                SetVehicleMod(vehs, 48, 1)
            end
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