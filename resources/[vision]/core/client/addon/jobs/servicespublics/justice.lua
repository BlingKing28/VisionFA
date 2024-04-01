local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

function LoadJustice()
    local justiceDuty = false
    local openRadial = false
    function ContratJustice()
        if justiceDuty then
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
        if justiceDuty then
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

    function FactureJustice()
        if justiceDuty then
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

    function OpenRadialJusticeMenu()
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
                            action = "FactureJustice"
                        },
                        {
                            name = "PRISE DE SERVICE",
                            icon = "assets/svg/radial/checkmark.svg",
                            action = "setJusticeDuty"
                        },
                        {
                            name = "CONTRAT",
                            icon = "assets/svg/radial/paper.svg",
                            action = "ContratJustice"
                        }
                    }, title = "JUSTICE"
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
    
    function closeRadialMenu()
        SendNuiMessage(json.encode({
            type = 'closeWebview',
        }))
    end

    function setJusticeDuty()
        openRadial = false
        closeUI()
        if justiceDuty then
            TriggerServerEvent('core:DutyOff', 'justice')
            --  ShowNotification("Vous avez ~r~quitté~s~ votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s quitté ~c votre service"
            })
            justiceDuty = false
            Wait(5000)
        else
            TriggerServerEvent('core:DutyOn', 'justice')
            --  ShowNotification("Vous avez ~r~quitté~s~ votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s pris ~c votre service"
            })
            justiceDuty = true
            Wait(5000)
        end
    end

    RegisterJobMenu(OpenRadialJusticeMenu)

    zone.addZone(
        "justice_delete",
        vector3(-570.42083740234, -145.66032409668, 37.799659729004),
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
        "society_justice",
        vector3(-515.78784179688, -184.06074523926, 38.219623565674),
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
        "coffre_justice",
        vector3(-547.65124511719, -185.03454589844, 37.21968460083),
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

    zone.addZone(
        "justice_spawn",
        vector3(-583.15130615234, -146.1902923584, 38.230819702148),
        "Appuyer sur ~INPUT_CONTEXT~ pour sortir le véhicule",
        function()
            OpenMenuVehJustice() --TODO: fini le menu society
        end,
        false,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    local listVehJustice = {
        headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_justice.webp',
        headerIcon = 'assets/icons/voiture-icon.png',
        headerIconName = 'VEHICULES',
        callbackName = 'vehMenuJustice',
        elements = {
            {
                id = 1,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Concessionnaire/Voiture/oracle2.webp',
                label = 'Oracle',
                name = "lspdoraclemk2um"
            },
            {
                id = 2,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscoutum.webp',
                label = 'Scout',
                name = "lspdscoutum"
            },
        }
    }

    function OpenMenuVehJustice()
        forceHideRadar()
            SendNuiMessage(json.encode({
                type = 'openWebview',
                name = 'MenuCatalogue',
                data = listVehJustice
            }))
    end

end

local waitForCar = false
RegisterNUICallback("vehMenuJustice", function (data, cb)
    if not waitForCar then
        waitForCar = true
        if vehicle.IsSpawnPointClear(vector3(-575.73504638672, -149.74160766602, 37.941028594971), 3.0) then
            RageUI.CloseAll()
            open = false
            if DoesEntityExist(vehs) then
                removeKeys(GetVehicleNumberPlateText(vehs), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(vehs))
                TriggerEvent('persistent-vehicles/forget-vehicle', vehs)
                removeKeys(GetVehicleNumberPlateText(vehs), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(vehs))
                DeleteEntity(vehs)
            end
            vehs = vehicle.create(data.name,
                vector4(-575.84429931641, -148.79403686523, 37.886444091797, 206.53550720215),
                {})

            SetVehicleCustomSecondaryColour(vehs, 0, 0, 0)
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)

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
        waitForCar = false
    end
end)

function UnLoadJustice()
    zone.removeZone("coffre_justice")
    zone.removeZone("society_justice")
    zone.removeZone("justice_delete")
    zone.removeZone('justice_spawn')
    justiceDuty = false
    openRadial = false
end

function MakeBillingPlayer(entity)
    local billing_price = 0
    local billing_reason = ""
    local player = NetworkGetPlayerIndexFromPed(entity)
    local sID = GetPlayerServerId(player)
    local price = KeyboardImput("Entrez le prix")
    if price and type(tonumber(price)) == "number" then
        billing_price = tonumber(price)
    else
        --[[ ShowAdvancedNotification("Centrale", "Facturation", "Veuillez entrer un nombre", "CHAR_CALL911",
            "CHAR_CALL911") ]]

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
            TriggerServerEvent('core:sendbilling', token, GetPlayerServerId(closestPlayer),
                "player", billing_price, billing_reason)
        else
            --[[ ShowAdvancedNotification("Centrale", "Facturation", "Aucun joueur dans la zone", "CHAR_BRYONY",
                "CHAR_BRYONY") ]]

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Aucun joueur dans la zone"
            })

        end
    else
        TriggerServerEvent('core:sendbilling', token, sID,
            "player", billing_price, billing_reason)
        -- ShowNotification("Facturation envoyée \n Prix : ~g~" ..
        --    billing_price .. "~s~$ \n Raison : " .. billing_reason)

        -- New notif
        exports['vNotif']:createNotification({
            type = 'VERT',
            -- duration = 5, -- In seconds, default:  4
            content = "Facturation envoyée \nPrix : ~s " .. billing_price .. "$ \n~c Raison : ~s " .. billing_reason
        })

    end
end
