function LoadVangelico()
    local token = nil
    TriggerEvent("core:RequestTokenAcces", "core", function(t)
        token = t
    end)

    local openRadial = false
    local inService = false
    local posGestion = vector3(-630.88055419922, -229.7059173584, 37.057060241699)
    local posCoffre = vector3(-620.89434814453, -224.61485290527, 37.056915283203)

    local posVangelico = {
        { name = "coffre_vangelico", pos = posCoffre,
            action = function()
                if inService then
                    OpenInventorySocietyMenu()
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
        { name = "gestion_vangelico", pos = posGestion,
            action = function()
                if inService then
                    OpenSocietyMenu()
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
    }
    
    for key, v in pairs(posVangelico) do
        print(v.name)
        zone.addZone(
            v.name,
            v.pos.xyz,
            "Appuyer sur ~INPUT_CONTEXT~ pour intéragir",
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

    function FactureVangelico()
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

    function SetVangelicoDuty()
        openRadial = false
        closeUI()
        if not inService then
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez ~s pris ~c votre service"
            })

            TriggerServerEvent('core:DutyOn', "vangelico")
            inService = true
            Wait(5000)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous avez ~s quitté ~c votre service"
            })

            TriggerServerEvent('core:DutyOff', "vangelico")
            inService = false
            Wait(5000)
        end
    end

    function StockMenu()
        if inService then
            openRadial = false
            closeUI()
            handleOpenCommandMenu()
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
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

    function OpenRadialVangelico()
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
                            action = "FactureVangelico"
                        },
                        {
                            name = "PRISE DE SERVICE",
                            icon = "assets/svg/radial/checkmark.svg",
                            action = "SetVangelicoDuty"
                        },
                        {
                            name = "COMMANDE",
                            icon = "assets/svg/radial/carton.svg",
                            action = "StockMenu"
                        }
                    }, title = "VANGELICO" }
                }));
            end)
        else
            openRadial = false
            closeUI()
            return
        end
    end

    RegisterJobMenu(OpenRadialVangelico)
    function UnLoadVangelico()
        for key, v in pairs(posVangelico) do
            zone.removeZone(v.name)
        end
    end
end