function LoadGouvJob()
    local token = nil
    TriggerEvent("core:RequestTokenAcces", "core", function(t)
        token = t
    end)

    zone.addZone(
        "gouv_delete",
        vector3(-570.53234863281, -145.54238891602, 37.778263092041),
        "Appuyer sur ~INPUT_CONTEXT~ pour ranger le véhicule",
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
                        content = "~s Votre véhicule est trop abimé"
                    })
                end
            end

        end,
        true,
        36, 0.5, { 255, 0, 0 }, 255
    )
    zone.addZone(
        "society_gouv",
        vector3(-544.36950683594, -199.47077941895, 47.54615020752),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les actions d'entreprise",
        function()
            OpenSocietyMenu() --TODO: fini le menu society
        end,
        false,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    zone.addZone(
        "coffre_gouv",
        vector3(-552.38275146484, -197.94941711426, 47.54615020752),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le coffre de l'entreprise",
        function()
            OpenInventorySocietyMenu() --TODO: fini le menu society
        end,
        false,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    zone.addZone("casier_gouv", vector3(-567.16662597656, -195.13107299805, 38.219741821289),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les casiers",
        function()
            OpenGouvCasier() -- TODO: fini le menu society
        end, false, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    local gouvDuty
    local openRadial = false
    function GouvDuty()
        openRadial = false
        closeUI()
        if gouvDuty then
            TriggerServerEvent('core:DutyOff', pJob)
            --  ShowNotification("Vous avez ~r~quitté~s~ votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s quitté ~c votre service"
            })
            gouvDuty = false
            Wait(5000)
        else
            TriggerServerEvent('core:DutyOn', pJob)
            --  ShowNotification("Vous avez ~r~quitté~s~ votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s pris ~c votre service"
            })
            gouvDuty = true
            Wait(5000)
        end
    end

    function ContratGouv()
        if gouvDuty then
            openRadial = false
            closeUI()
            TriggerEvent("nuiPapier:client:startCreation", 3, 'assets/entrepriseCarre/justice.jpg')
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function CreateAdvert()
        if gouvDuty then
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

    function FactureGouv()
        if gouvDuty then
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

    function OpenGouvRadial()
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
                            action = "FactureGouv"
                        },
                        {
                            name = "PRISE DE SERVICE",
                            icon = "assets/svg/radial/checkmark.svg",
                            action = "GouvDuty"
                        },
                        {
                            name = "CONTRAT",
                            icon = "assets/svg/radial/paper.svg",
                            action = "ContratGouv"
                        }
                    }, title = "GOUVERNEMENT"
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
                type = 'closeWebview',
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
    
    function CloseWebApp()
        SendNuiMessage(json.encode({
            type = 'closeWebview',
        }))
    end

    local casierOpen = false
    function OpenGouvCasier()
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

    RegisterJobMenu(OpenGouvRadial)
    zone.addZone(
        "spawn_gouv",
        vector3(-583.06512451172, -146.10768127441, 37.230884552002),
        "Appuyer sur ~INPUT_CONTEXT~ pour sortir le véhicule",
        function()
            OpenMenuVehGouv() --TODO: fini le menu society
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    local listVeh = {
        headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_justice.webp',
        headerIcon = 'assets/icons/voiture-icon.png',
        headerIconName = 'VEHICULES',
        callbackName = 'vehMenuGouv',
        elements = {
            {
                id = 1,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Concessionnaire/Voiture/washington.webp',
                label = 'Washington',
                name = "washington"
            },
        }
    }

    function OpenMenuVehGouv()
        forceHideRadar()
            SendNuiMessage(json.encode({
                type = 'openWebview',
                name = 'MenuCatalogue',
                data = listVeh
            }))
    end

end

RegisterNUICallback("vehMenuGouv", function (data, cb)
    if vehicle.IsSpawnPointClear(vector3(-575.73504638672, -149.74160766602, 37.941028594971), 3.0) then
        RageUI.CloseAll()
        open = false
        if DoesEntityExist(vehs) then
            TriggerEvent('persistent-vehicles/forget-vehicle', vehs)
            removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
            TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
            DeleteEntity(vehs)
        end
        vehs = vehicle.create(data.name,
            vector4(-575.73504638672, -149.74160766602, 37.941028594971, 205.38610839844),
            {})
        local plate = vehicle.getProps(vehs).plate
        local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
        local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
        createKeys(plate, model)
        if data.name == "nspeedo" then
            SetVehicleMod(vehs, 48, 12)
            SetVehicleLivery(vehs, 12)
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
end)
