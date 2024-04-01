function LoadLabel()
    if pJob ~= "rockford" and pJob ~= "records" then
        return
    end
    local inService = false
    local openRadial = false
    local jobName = p:getJob()
    local posCoffre, posGestion = vec3(0,0,0), vec3(0,0,0)

    if pJob == "records" then
        posCoffre = vec3(0,0,0)
        posGestion = vec3(0,0,0)
    else
        posCoffre = vec3(-996.52142333984, -307.82968139648, 43.797317504883)
        posGestion = vec3(-1007.7181396484, -264.82049560547, 43.795902252197)
    end

    local pos = {
        {
            name = "Coffre_"..jobName, pos = posCoffre,
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
            name = "Gestion_"..jobName, pos = posGestion,
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

    function FactureLabel()
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

    function SetLabelDuty()
        openRadial = false
        closeUI()
        if not inService then
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez ~s pris ~c votre service"
            })

            TriggerServerEvent('core:DutyOn', jobName)
            inService = true
            Wait(5000)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous avez ~s quitté ~c votre service"
            })

            TriggerServerEvent('core:DutyOff', jobName)
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

    function ContratLabel()
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
    
    function OpenRadialLabel()
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
                            action = "FactureLabel"
                        },
                        {
                            name = "PRISE DE SERVICE",
                            icon = "assets/svg/radial/checkmark.svg",
                            action = "SetLabelDuty"
                        },
                        {
                            name = "CONTRAT",
                            icon = "assets/svg/radial/paper.svg",
                            action = "ContratLabel"
                        }
                    }, title = string.upper(pJob) }
                }));
            end)
        else
            openRadial = false
            closeUI()
            return
        end
    end

    RegisterJobMenu(OpenRadialLabel)

    function UnLoadLabel()
        for key, v in pairs(pos) do
            zone.removeZone(v.name)
        end
        zone.removeZone(jobName.."_delete")
    end
end