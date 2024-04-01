local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

CreateThread(function()
    while zone == nil do Wait(1)end

    local ped2 = entity:CreatePedLocal("s_m_m_armoured_02", vector3(-583.06512451172, -146.10768127441, 37.230884552002),  200.0)
    ped2:setFreeze(true)
    SetEntityInvincible(ped2.id, true)
    SetEntityAsMissionEntity(ped2.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped2.id, true)

    local ped3 = entity:CreatePedLocal("s_m_m_armoured_02", vector3(2510.7231445313, -336.23788452148, 117.02342987061),  97.0)
    ped3:setFreeze(true)
    SetEntityInvincible(ped3.id, true)
    SetEntityAsMissionEntity(ped3.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped3.id, true)

end)

local usss_heli = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/header_usss.webp',
    headerIcon = 'assets/LSPD/logo_helicoptere.png',
    headerIconName = 'HÉLICOPTÈRES',
    callbackName= 'Menu_usss_heli_callback',
    elements = {
        {
            label = 'Marine One',
            name = 'presheli2',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/presheli2.webp",
            category= 'USSS'
        },
        {
            label = 'Buzzard',
            name = 'buzzard4',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/buzzard4.webp",
            category= 'USSS'
        },
    },
}

usssDuty = false
function LoadUSSS()

    local coffrePos = {
        vector3(2526.0004882813, -335.40567016602, 93.092239379883),
    }

    for k, v in pairs(coffrePos) do
        zone.addZone(
            "casier_Usss" .. k,
            v,
            "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les casiers",
            function()
                if usssDuty then
                    OpenUsssCasier() --TODO: fini le menu society
                else
                    -- ShowNotification("~r~Vous n'êtes pas en service")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous n'êtes ~s pas en service"
                    }) 
                end
            end,
            false,
            25, -- Id / type du marker
            0.6, -- La taille
            { 51, 204, 255 }, -- RGB
            170-- Alpha
        )
    end

    local casierOpen = false
    function OpenUsssCasier()
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


    zone.addZone("usss_item", vector3(2521.4313964844,  -336.58444213867, 100.89331817627),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir l'armurerie ", 
        function()
            OpenUsssITEMMenu()
        end,
        false, -- Avoir un marker ou non
        -1, -- Id / type du marker
        0.6, -- La taille
        { 0, 0, 0 }, -- RGB
        0, -- Alpha
        2.5 -- Interact dist
    )
    zone.addZone(
        "society_usss_custom",
        vector3(2514.2377929688, -462.03964233398, 92.992897033691),
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

    -- DEV
    zone.addZone("usss_vest", vector3(2521.5610351563, -331.21557617188, 93.092239379883),
        "Appuyer sur ~INPUT_CONTEXT~ pour prendre une tenue", 
        function()
            USSSVestiaireDev()
        end,
        true, -- Avoir un marker ou non
        -1, -- Id / type du marker
        0.6, -- La taille
        { 0, 0, 0 }, -- RGB
        0, -- Alpha
        2.5 -- Interact dist
    )

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
                        for k, v in pairs(usss.outfit) do
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
    
    local items = {
        headerImage = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Banners/USSS.webp",
        headerIcon = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Banners/icon.webp',
        headerIconName = 'CATALOGUE',
        callbackName = 'armoryTakeUSSS',
        multipleSelection = true,
        showTurnAroundButtons = false,
        elements = {            
            --{            
            --    price = 0,
            --    id = 1,
            --    image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Radio.webp",
            --    name = "radio",
            --    label = "Radio",
            --},            
            {            
                price = 0,
                id = 2,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Bouclier_anti_emeute.webp",
                name = "shield",
                label = "Bouclier anti-émeute",
            },
            --{            
            --    price = 0,
            --    id = 3,
            --    image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/weapon_fireextinguisher.webp",
            --    name = "weapon_fireextinguisher",
            --    label = "Extincteur",
            --},
            {           
                price = 0,
                id = 3,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Fumigene.webp",
                name = "weapon_smokelspd",
                label = "Fumigene",
            },
            {            
                price = 0,
                id = 4,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Fusee_detresse.webp",
                name = "weapon_flare",
                label = "Fusée de détresse",
            },
            {            
                price = 0,
                id = 5,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Gaz_bz.webp",
                name = "weapon_bzgas",
                label = "GAZ BZ",
            },
            --{           
            --    price = 0,
            --    id = 7,
            --    image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/herse.webp",
            --    name = "herse",
            --    label = "Herses",
            --},            
            --{            
            --    price = 0,
            --    id = 8,
            --    image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/weapon_nightstick.webp",           
            --    name = "weapon_nightstick",
            --    label = "Matraque",
            --},            
            --{            
            --    price = 0,
            --    id = 6,
            --    image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Taser.webp",
            --    name = "weapon_stungun_mp",
            --    label = "Taser",
            --},            
            --{            
            --    price = 0,
            --    id = 10,
            --    image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Boite_cartouches.webp",
            --    name = "ammo30",
            --    label = "Boite de munitions",
            --},            
           -- {            
           --     price = 0,
           --     id = 11,
           --     image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/weapon_pistol.webp",           
           --     name = "weapon_pistol",
           --     label = "Pistolet",
           -- },            
           -- {            
           --     price = 0,
           --     id = 12,
           --     image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/weapon_pistolcombat.webp",           
           --     name = "weapon_combatpistol",
           --     label = "Pistolet de combat",
           -- },            
           -- {            
           --     price = 0,
           --     id = 13,
           --     image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/weapon_heavypistol.webp",           
           --     name = "weapon_heavypistol",
           --     label = "Pistolet lourd",
           -- },
            --{            
            --    price = 0,
            --    id = 7,
            --    image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/weapon_beambag.webp",           
            --    name = "weapon_beambag",
            --    label = "Beambag",
            --},
          --  {            
          --      price = 0,
          --      id = 15,
          --      image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/weapon_pumpshotgun.webp",           
          --      name = "weapon_pumpshotgun",
          --      label = "Fusil à pompe",
          --  },
          --  {            
          --      price = 0,
          --      id = 16,
          --      image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/weapon_carbinerifle.webp",           
          --      name = "weapon_carbinerifle",
          --      label = "Carabine",
          --  },
          --  {            
          --      price = 0,
          --      id = 17,
          --      image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/weapon_smg.webp",           
          --      name = "weapon_smg",
          --      label = "SMG",
          --  },
            {         
                price = 0,
                id = 8,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/ussskev1.webp",
                name = "ussskev1",
                label = "Kelvar Class C 1",
            },
            {            
                price = 0,
                id = 9,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/ussskev2.webp",
                name = "ussskev2",
                label = "Kelvar Class C 2",
            },           
            {           
                price = 0,
                id = 10,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/ussskev3.webp",
                name = "ussskev3",
                label = "Kelvar Class C 3",
            },
            {           
                price = 0,
                id = 11,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/ussskev4.webp",
                name = "ussskev4",
                label = "Kelvar Class A",
            },
            {           
                price = 0,
                id = 12,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Insigne_Usss.webp",
                name = "insigneKevUsss",
                label = "USSS - Insigne",
            },
        },
    }

    function OpenUsssITEMMenu()
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

    Keys.Register("F2", "F2", "Faire un appel de renfort", function()
        makeRenfortCallUSSS()
    end)

    function ConvocationUSSS()
        if usssDuty then
            openRadial = false
            closeUI()
            TriggerEvent("nuiPapier:client:startCreation", 5)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function FactureUSSS()
        if usssDuty then
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

    function DepositionUSSS()
        if usssDuty then
            openRadial = false
            closeUI()
            TriggerEvent("nuiPapier:client:startCreation",4)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function CreateAdvert()
        if usssDuty then
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

    function makeRenfortCallUSSS()
        if usssDuty then
            TriggerServerEvent('core:makeCall', "usss", p:pos(), false, "appel de renfort")
            --ExecuteCommand("me fait un appel de renfort")
            --p:PlayAnim('amb@code_human_police_investigate@idle_a', 'idle_b', 51)
            openRadial = false
            closeUI()
            --Modules.UI.RealWait(10000)
            --ClearPedTasks(p:ped())
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

    function OpenRadialUSSSMenu()
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
                function OpenSubRadialPapiers()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "CONVOCATION",
                                icon = "assets/svg/radial/top_paper.svg",
                                action = "ConvocationUSSS"
                            },
                            {
                                name = "FACTURE",
                                icon = "assets/svg/radial/billet.svg",
                                action = "FactureUSSS"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenMainRadialUSSS"
                            },
                            {
                                name = "DEPOSITION",
                                icon = "assets/svg/radial/paper.svg",
                                action = "DepositionUSSS"
                            }
                        }, 
                        title = "PAPIERS",
                        }
                    }));
                end

                function OpenSubRadialActions()
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
                                name = "CIRCULATION",
                                icon = "assets/svg/radial/road.svg",
                                action = "openTraficMenu"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenMainRadialUSSS"
                            },
                            {
                                name = "OBJETS",
                                icon = "assets/svg/radial/object.svg",
                                action = "OpenPropsMenuUSSS"
                            }
                        }, 
                        title = "ACTIONS",
                        }
                    }));
                end

                function OpenMainRadialUSSS()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "APPEL DE RENFORT",
                                icon = "assets/svg/radial/police_logo.svg",
                                action = "makeRenfortCallUSSS"
                            }, 
                            {
                                name = "PAPIERS",
                                icon = "assets/svg/radial/paper.svg",
                                action = "OpenSubRadialPapiers"
                            },
                            {
                                name = "PRISE DE SERVICE",
                                icon = "assets/svg/radial/checkmark.svg",
                                action = "SetUSSSDuty"
                            },
                            {
                                name = "ACTIONS",
                                icon = "assets/svg/radial/police.svg",
                                action = "OpenSubRadialActions"
                            }
                        }, title = "USSS"}
                    }));
                end

                OpenMainRadialUSSS()
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
    local usssmenu_objects = RageUI.CreateMenu("", "USSS", 0.0, 0.0, "vision", "menu_tittle_usss")
    local usssmenu_traffic = RageUI.CreateMenu("", "USSS", 0.0, 0.0, "vision", "menu_tittle_usss")
    local usssmenu_traffic_view = RageUI.CreateSubMenu(usssmenu_traffic, "", "USSS", 0.0, 0.0, "vision",
        "menu_tittle_usss")
    local usssmenu_traffic_add = RageUI.CreateSubMenu(usssmenu_traffic, "", "USSS", 0.0, 0.0, "vision",
        "menu_tittle_usss")
    local usssmenu_objects_delete = RageUI.CreateSubMenu(usssmenu_objects, "", "USSS", 0.0, 0.0, "vision",
        "menu_tittle_usss")
    usssmenu_objects.Closed = function()
        open = false
    end
    usssmenu_traffic.Closed = function()
        open = false
        speed = 0.0
        radius = 0.0
        show = false
        zoneName = ""
    end

    
    local traficList = {}
    local speed = 0.0
    local radius = 0.0
    local show = false
    local zoneName = ""
    local zonePos = vector3(0, 0, 0)

    function openTraficMenu()
        if usssDuty then
            -- open a menu with 2 buttons : one to add a new zone and one to view my zones
            if open then
                open = false
                RageUI.Visible(usssmenu_traffic, false)
            else
                open = true
                RageUI.Visible(usssmenu_traffic, true)

                Citizen.CreateThread(function()
                    while open do
                        RageUI.IsVisible(usssmenu_traffic, function()
                            -- for the first button to add a new zone, it opens a menu where i can set the speed in the zone and the radius of the zone, another checkbox to show it on my client and a last button to add the zone
                            RageUI.Button("Ajouter une zone", nil, { RightLabel = ">" }, true, {
                                onSelected = function()
                                    zonePos = p:pos()
                                end
                            }, usssmenu_traffic_add)
                            -- for the second button to view my zones, it opens a menu where i can see all my zones and delete them
                            RageUI.Button("Voir les zones", nil, { RightLabel = ">" }, true, {
                                onSelected = function()
                                    traficList = TriggerServerCallback("lspd:traffic:get")
                                end
                            }, usssmenu_traffic_view)
                        end)
                        RageUI.IsVisible(usssmenu_traffic_add, function()
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
                        RageUI.IsVisible(usssmenu_traffic_view, function()
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

    function SetUSSSDuty()
        if usssDuty then
            TriggerServerEvent('core:DutyOff', 'usss')
            --  ShowNotification("Vous avez ~r~quitté~s~ votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s quitté ~c votre service"
            })
            usssDuty = false
            Wait(5000)
        else
            TriggerServerEvent('core:DutyOn', 'usss')
            --  ShowNotification("Vous avez ~r~quitté~s~ votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s pris ~c votre service"
            })
            usssDuty = true
            Wait(5000)
        end
    end

    RegisterJobMenu(OpenRadialUSSSMenu)

    zone.addZone("USSS_spawn_nord", vector3(2527.5854, -454.3905, 93.1942),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage", function()
            menuChoose = 'car'
            OpenMenuVehUsss()
        end, false, 27, 0.7, { 17, 201, 198 }, 255
    )

    zone.addZone("USSS_spawn_sud", vector3(-582.91174316406, -146.59237670898, 37.230670928955),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage", function()
            menuChoose = 'car'
            OpenMenuVehUsss()
        end, false, 27, 0.7, { 17, 201, 198 }, 255
    )

    zone.addZone("USSS_delete_nord", vector3(2521.0789, -459.4331, 92.9929),
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

    zone.addZone("USSS_delete_sud", vector3(-570.87316894531, -144.31098937988, 37.591369628906),
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

    local open = false
    local main = RageUI.CreateMenu("", "Action Disponible", 0.0, 0.0, "vision", "menu_tittle_usss")

    local vehs = nil
    ---OpenVeh

    function OpenMenuHeliUsss()
        forceHideRadar()
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogue',
            data = usss_heli
        }))
    end
    
    zone.addZone(
        "spawn_usss_heli",
        vector3(2510.197265625, -336.37561035156, 117.02337646484),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        function()
            menuChoose = 'heli'
            OpenMenuHeliUsss()
        end,
        false,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170--
    )
    zone.addZone(
        "society_usssHeli_delete",
        vector3(2510.9650878906, -341.83529663086, 118.18536376953),
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
        34, 0.6, { 255, 0, 0 }, 170
    )
    zone.addZone("society_USSS", vector3(2511.9467773438, -423.30465698242, 105.91291809082),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les actions d'entreprise", function()
            OpenSocietyMenu()
        end, true, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone("coffre_USSS2", vector3(2525.1513671875, -332.98590087891, 100.89334869385),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le coffre de l'entreprise", function()
            OpenInventorySocietyMenu()
        end, true, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

   
    RegisterNUICallback("focusOut", function (data, cb)
        TriggerScreenblurFadeOut(0.5)
        DisplayHud(true)
        openRadarProperly()
    end)

    local oldSkin = {}
    local open = false
    local outfitmenu = RageUI.CreateMenu("", "USSS", 0.0, 0.0, "vision", "menu_tittle_usss")
    local outfitmenu_list = RageUI.CreateSubMenu(outfitmenu, "", "USSS", 0.0, 0.0, "vision", "menu_tittle_usss")
    outfitmenu.Closed = function()
        local playerSkin = p:skin()
        ApplySkin(oldSkin)
        open = false
    end

    local selected_table = {}

    function openOutfitMenuUSSS()
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
    -- usss teleporter 1
    zone.addZone(
        "enterUsss",
        vector3(-602.41302490234, -99.495086669922, 33.123710632324),
        "Appuyez sur ~INPUT_CONTEXT~ pour entrer",
        function()
            enterUsss()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    zone.addZone(
        "leaveUsss",
        vector3(8.5853366851807, -920.16705322266, 13.903322219849),
        "Appuyez sur ~INPUT_CONTEXT~ pour sortir",
        function()
            LeaveUsss()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    function enterUsss()
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Wait(0)
        end        
        SetEntityCoords(p:ped(), vector3(8.5853366851807, -920.16705322266, 13.903322219849), false, false, false, true)
        Wait(50)
        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Wait(1) end
        SetEntityCoords(p:ped(), vector3(8.5853366851807, -920.16705322266, 13.903322219849), false, false, false, true)

        DoScreenFadeIn(800)
    end

    function LeaveUsss()
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Wait(0)
        end
        SetEntityCoords(p:ped(), vector3(-602.41302490234, -99.495086669922, 33.123710632324), false, false, false, true)
        Wait(50)
        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Wait(1) end
        SetEntityCoords(p:ped(), vector3(-602.41302490234, -99.495086669922, 33.123710632324), false, false, false, true)
        DoScreenFadeIn(800)
    end

    -- usss teleporter 2
    zone.addZone(
        "enterUsss1",
        vector3(-588.765625, -135.44633483887, 38.610706329346),
        "Appuyez sur ~INPUT_CONTEXT~ pour entrer",
        function()
            enterUsss1()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone(
        "leaveUsss1",
        vector3(30.109233856201, -902.08569335938, 13.902673721313),
        "Appuyez sur ~INPUT_CONTEXT~ pour sortir",
        function()
            LeaveUsss1()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    function enterUsss1()
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Wait(0)
        end        
        SetEntityCoords(p:ped(), vector3(30.109233856201, -902.08569335938, 13.902673721313), false, false, false, true)
        Wait(50)
        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Wait(1) end
        SetEntityCoords(p:ped(), vector3(30.109233856201, -902.08569335938, 13.902673721313), false, false, false, true)

        DoScreenFadeIn(800)
    end

    function LeaveUsss1()
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Wait(0)
        end
        SetEntityCoords(p:ped(), vector3(-588.765625, -135.44633483887, 38.610706329346), false, false, false, true)
        Wait(50)
        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Wait(1) end
        SetEntityCoords(p:ped(), vector3(-588.765625, -135.44633483887, 38.610706329346), false, false, false, true)
        DoScreenFadeIn(800)
    end
    
end

function PlacePlayerIntoVehicleForUsss(entity)
    if usssDuty then
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

local usss_entree = vector3(-561.56018066406, -131.82708740234, 37.212070465088)
local usss_sortie = vector3(8.5571641921997, -932.66754150391, 13.902667999268)


zone.addZone(
    "usss_tp",
    usss_entree,
    "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
    function()
        SetEntityCoords(p:ped(), usss_sortie)
        Wait(1000)
    end,
    true,
    25, -- Id / type du marker
    0.6, -- La taille
    { 51, 204, 255 }, -- RGB
    170-- Alpha
)
zone.addZone(
    "usss_ls",
    usss_sortie,
    "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
    function()
        SetEntityCoords(p:ped(), usss_entree)
        Wait(1000)
    end,
    true,
    25, -- Id / type du marker
    0.6, -- La taille
    { 51, 204, 255 }, -- RGB
    170-- Alpha
)


RegisterNUICallback("Menu_usss_heli_callback", function (data, cb)
    local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -745.4596, -1468.6624, 5.0005)
    if distance < 50.0 then
        if vehicle.IsSpawnPointClear(vector3(-745.4596, -1468.6624, 5.0005), 3.0) then
            -- if DoesEntityExist(vehs) then
            --     TriggerEvent('persistent-vehicles/forget-vehicle', vehs)
            --     DeleteEntity(vehs)
            -- end
            vehs = vehicle.create(data.name, vector4(-745.4596, -1468.6624, 5.0005, 319.8339), {})
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
            SetVehicleMod(vehs, 11, 1, false)
            SetVehicleMod(vehs, 12, 1, false)
            SetVehicleMod(vehs, 13, 1, false)
            SendNuiMessage(json.encode({
                type = 'closeWebview',
            }))
        else
            -- ShowNotification("Il n'y a pas de place pour le véhicule")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Il n'y a ~s pas de place ~c pour l'hélicoptère"
            })
        end
    else
        if vehicle.IsSpawnPointClear(vector3(2511.720703125, -341.0754699707, 117.1854019165), 3.0) then
            -- if DoesEntityExist(vehs) then
            --     TriggerEvent('persistent-vehicles/forget-vehicle', vehs)
            --     DeleteEntity(vehs)
            -- end
            vehs = vehicle.create(data.name, vector4(2511.720703125, -341.0754699707, 117.1854019165, 316.54864501953), {})
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
            SetVehicleMod(vehs, 11, 1, false)
            SetVehicleMod(vehs, 12, 1, false)
            SetVehicleMod(vehs, 13, 1, false)
            SendNuiMessage(json.encode({
                type = 'closeWebview',
            }))
        else
            -- ShowNotification("Il n'y a pas de place pour le véhicule")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Il n'y a ~s pas de place ~c pour l'hélicoptère"
            })
        end
    end
end)

RegisterNUICallback("Menu_usss_vehicule_callback", function (data, cb)
    local distancenord = GetDistanceBetweenCoords(2521.0789, -459.4331, 92.9929, GetEntityCoords(PlayerPedId()))
    if distancenord < 50.0 then
        if vehicle.IsSpawnPointClear(vector3(2521.0789, -459.4331, 92.9929), 5.0) then
            -- if DoesEntityExist(vehs) then
            --     TriggerEvent('persistent-vehicles/forget-vehicle', vehs)
            --     DeleteEntity(vehs)
            -- end
            vehs = vehicle.create(data.name, vector4(2521.0789, -459.4331, 92.9929, 187.0411), {})
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
            SetVehicleMod(vehs, 11, 1, false)
            SetVehicleMod(vehs, 12, 1, false)
            SetVehicleMod(vehs, 13, 1, false)
            if data.name == "lspdspeedo" then
                SetVehicleLivery(vehs, 2)
            end
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
        if vehicle.IsSpawnPointClear(vector3(-575.38079833984, -150.53619384766, 37.002952575684), 5.0) then
            -- if DoesEntityExist(vehs) then
            --     TriggerEvent('persistent-vehicles/forget-vehicle', vehs)
            --     DeleteEntity(vehs)
            -- end
            vehs = vehicle.create(data.name, vector4(-575.38079833984, -150.53619384766, 37.002952575684, 201.27742004395), {})
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
            SetVehicleMod(vehs, 11, 1, false)
            SetVehicleMod(vehs, 12, 1, false)
            SetVehicleMod(vehs, 13, 1, false)
            if data.name == "lspdspeedo" then
                SetVehicleLivery(vehs, 2)
            end
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


    -- MENU PROPS


    local usssPropsPlaced = {}

    local function SpawnPropsUSSS(obj, name)
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

                OpenPropsMenuUSSS()
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
        table.insert(usssPropsPlaced, {
            nom = name,
            prop = objS.id
        })
    end

       
    PropsMenu = {
        cam = nil,
        open = false,
    }
    
    RegisterNUICallback("focusOut", function()
        if PropsMenu.open then
            PropsMenu.open = false 
        end
    end)
    
    DataSendPropsUSSS = {
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
                        name = 'Drogues',
                        width = 'full',
                        image = 'assets/PropsMenu/drogues.svg',
                        hoverStyle = ' stroke-black'
                    },
                    {
                        name = 'Divers',
                        width = 'full',
                        image = 'assets/PropsMenu/divers.svg',
                        hoverStyle = ' stroke-black'
                    },
                    {
                        name = 'Cibles Tir',
                        width = 'full',
                        image = 'assets/PropsMenu/ciblestir.svg',
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
                name = 'Drogues',
                type = 'elements',
                elements = {},
            },
            {
                name = 'Divers',
                type = 'elements',
                elements = {},
            },
            {
                name = 'Cibles Tir',
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
        headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/header_usss.webp',
        callbackName = 'MenuObjetsServicesPublicsUSSS',
        showTurnAroundButtons = false,
    }
    
    local firstart = false


local cones_models = {
    ['#1']     = "prop_air_conelight",
    ['#2']     = "prop_barrier_wat_03b",
    ['#3']     = "prop_mp_cone_03",
    ['#4']     = "prop_mp_cone_04",
    ['#5']     = "prop_roadcone02a",
    ['#6']     = "prop_roadcone02b",
    ['#7']     = "prop_roadpole_01a",
    ['#8']     = "prop_roadpole_01b",
    ['#9']     = "prop_trafficdiv_01",
    ['#10']     = "prop_trafficdiv_02",
}

local panneaux_models = {
    ['#1']     = "prop_consign_01b",
    ['#2']     = "prop_consign_02a",
    ['#3']     = "prop_sign_road_01a",
    ['#4']     = "prop_sign_road_03a",
    ['#5']     = "prop_sign_road_06a",
    ['#6']     = "prop_sign_road_06f",
    ['#7']     = "prop_sign_road_06q",
    ['#8']     = "prop_sign_road_06r",
}

local barriere_models = {
    ['#1']     = "prop_barier_conc_05c",
    ['#2']     = "prop_barrier_work01a",
    ['#3']     = "prop_barrier_work01b",
    ['#4']     = "prop_barrier_work02a",
    ['#5']     = "prop_barrier_work06b",
    ['#6']     = "prop_fncsec_04a",
    ['#7']     = "prop_mp_arrow_barrier_01",
    ['#8']     = "prop_mp_barrier_02b",
    ['#9']     = "prop_plas_barier_01a",
    ['#10']     = "prop_barrier_work05",
    ['#11']     = "prop_barrier_work06a",
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

local drogues_models = {
    ['#1']     = "bkr_prop_bkr_cashpile_01",
    ['#2']     = "bkr_prop_meth_openbag_02",
    ['#3']     = "bkr_prop_meth_smallbag_01a",
    ['#4']     = "bkr_prop_moneypack_03a",
    ['#5']     = "bkr_prop_weed_smallbag_01a",
    ['#6']     = "ex_office_swag_drugbag2",
    ['#7']     = "imp_prop_impexp_boxcoke_01",
    ['#8']     = "imp_prop_impexp_coke_pile",
}

local divers_models = {
    ['#1']     = "gr_prop_gr_laptop_01c",
    ['#2']     = "prop_rad_waste_barrel_01",
    ['#3']     = "prop_gazebo_02",
}

local sacs_models = {
    ['#1']     = "xm_prop_x17_bag_01c",
    ['#2']     = "xm_prop_x17_bag_med_01a",
}

local cibletir_models = {
    ['#1']     = "gr_prop_gr_target_05a",
    ['#2']     = "gr_prop_gr_target_05b",
}

RegisterNUICallback("MenuObjetsServicesPublicsUSSS", function(data, cb)
    -- if data == nil or data.category == nil then return end
    -- PropsMenu.choice = data.category

    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))

    if data.category == "Cones" then 
        print(data.label)
        
        SpawnPropsUSSS(cones_models[data.label], data.label)
    end
    
    if data.category == "Panneaux" then 
        print(data.label)
    
        SpawnPropsUSSS(panneaux_models[data.label], data.label)
    end

    if data.category == "Barrières" then 
        print(data.label)

        SpawnPropsUSSS(barriere_models[data.label], data.label)
    end

    if data.category == "Lumières" then 
        print(data.label)

        SpawnPropsUSSS(lumiere_models[data.label], data.label)
    end

    if data.category == "Tables" then 
        print(data.label)

        
        SpawnPropsUSSS(tables_models[data.label], data.label)
    end

    if data.category == "Drogues" then 
        print(data.label)

        
        SpawnPropsUSSS(drogues_models[data.label], data.label)
    end

    if data.category == "Divers" then 
        print(data.label)

        
        SpawnPropsUSSS(divers_models[data.label], data.label)
    end

    if data.category == "Cibles Tir" then 
        print(data.label)

        
        SpawnPropsUSSS(cibletir_models[data.label], data.label)
    end

    if data.category == "Sacs" then 
        print(data.label)

        
        SpawnPropsUSSS(sacs_models[data.label], data.label)
    end

end)

function OpenPropsMenuUSSS()
    if firstart == false then
        firstart = true 
        local bool = GetDatasPropsUSSS()
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
        data = DataSendPropsUSSS
    }))
end

function GetDatasPropsUSSS()
    -- DataSendPropsUSSS.items.elements = {}

    playerJobs = p:getJob()

    -- Cones
    for i = 1, 10 do
        table.insert(DataSendPropsUSSS.items[2].elements, {
            id = i,
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Cones/"..i..".webp",
            category="Cones", 
            label = "#"..i
        })
    end


   -- Panneaux
    for i = 1, 8 do
        table.insert(DataSendPropsUSSS.items[3].elements, {
            id = i,
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Panneaux/"..i..".webp",
            category="Panneaux",
            label = "#"..i
        })
    end

    -- Barrière
    for i = 1, 11 do
        table.insert(DataSendPropsUSSS.items[4].elements, {
            id = i,
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Barrieres/"..i..".webp",
            category="Barrières",
            label = "#"..i
        })
    end

    -- Lumières
    for i = 1, 5 do
        table.insert(DataSendPropsUSSS.items[5].elements, {
            id = i,
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Lumieres/"..i..".webp",
            category="Lumières",
            label = "#"..i
        })
    end

    -- Tables
    for i = 1, 2 do
        table.insert(DataSendPropsUSSS.items[6].elements, {
            id = i,
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Tables/"..i..".webp",
            category="Tables",
            label = "#"..i
        })
    end

    -- Drogues
    for i = 1, 8 do
        table.insert(DataSendPropsUSSS.items[7].elements, {
            id = i,
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Drogues/"..i..".webp",
            category="Drogues",
            label = "#"..i
        })
    end

    -- Divers
    for i = 1, 3 do
        table.insert(DataSendPropsUSSS.items[8].elements, {
            id = i,
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Divers/"..i..".webp",
            category="Divers",
            label = "#"..i
        })
    end

    -- Cible Tir
    for i = 1, 2 do
        table.insert(DataSendPropsUSSS.items[9].elements, {
            id = i,
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/CiblesTir/"..i..".webp",
            category="Cibles Tir",
            label = "#"..i
        })
    end

    -- Sacs
    for i = 1, 2 do
        table.insert(DataSendPropsUSSS.items[10].elements, {
            id = i,
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Sacs/"..i..".webp",
            category="Sacs",
            label = "#"..i
        })
    end


    DataSendPropsUSSS.disableSubmit = true

    return true
end


RegisterNUICallback("armoryTakeUSSS", function(data, cb)
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

local listVehUsss = {
    headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/header_usss.webp',
    headerIcon = 'assets/LSPD/logo_vehicule.png',
    headerIconName = 'VEHICULE',
    callbackName= 'Menu_usss_vehicule_callback',
    elements = {
        --uniform division
        {
            label = 'Vélo',
            name = 'pbike',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/pbike.webp",
            category= 'Uniform Division'
        },
        {
            label = 'Alamo',
            name = 'udoalamonew',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/udoalamonew.webp",
            category= 'Uniform Division'
        },
        {
            label = 'Bufallo',
            name = 'udobuff',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/udobuff.webp",
            category= 'Uniform Division'
        },
        {
            label = 'Alamo',
            name = 'udooldalamo',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/udooldalamo.webp",
            category= 'Uniform Division'
        },
        {
            label = 'Scout',
            name = 'udoscout',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/udoscout.webp",
            category= 'Uniform Division'
        },
        {
            label = 'Stanier Slick',
            name = 'udostanslick',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/udostanslick.webp",
            category= 'Uniform Division'
        },
        {
            label = 'Stanier',
            name = 'udostan',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/udostan.webp",
            category= 'Uniform Division'
        },
        {
            label = 'Torrence',
            name = 'udotorrence',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/udotorrence.webp",
            category= 'Uniform Division'
        },
        {
            label = 'Bombs',
            name = 'usssbombs',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/usssbombs.webp",
            category= 'Uniform Division'
        },
        {
            label = 'Speedo',
            name = 'lspdspeedo',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/lspdspeedo.webp",
            category= 'Uniform Division'
        },
        --close protecting
        {
            label = 'Cat',
            name = 'cat',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/cat.webp",
            category= 'Close Protecting'
        },
        {
            label = 'Half',
            name = 'halfback2',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/halfback2.webp",
            category= 'Close Protecting'
        },
        {
            label = 'Hazard',
            name = 'hazard2',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/hazard2.webp",
            category= 'Close Protecting'
        },
        {
            label = 'Inaugural',
            name = 'inaugural2',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/inaugural2.webp",
            category= 'Close Protecting'
        },
        {
            label = 'Idcar',
            name = 'idcar',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/idcar.webp",
            category= 'Close Protecting'
        },
        {
            label = 'Road Runner',
            name = 'roadrunner3',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/roadrunner3.webp",
            category= 'Close Protecting'
        },
        {
            label = 'Suv',
            name = 'ussssuv2',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/ussssuv2.webp",
            category= 'Close Protecting'
        },
    --[[             {
            label = 'Stanier',
            name = 'usssstanier',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/usssstanier.webp",
            category= 'Close Protecting'
        }, ]]
        {
            label = 'Flag',
            name = 'usssflag',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/usssflag.webp",
            category= 'Close Protecting'
        },
        {
            label = 'Watch tower',
            name = 'watchtower2',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/watchtower2.webp",
            category= 'Close Protecting'
        },
        {
            label = 'Van',
            name = 'usssvan',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/usssvan.webp",
            category= 'Close Protecting'
        },
        --unmarked
        {
            label = 'Everon',
            name = 'loweveron',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/loweveron.webp",
            category= 'Unmarked'
        },
        {
            label = 'Stalker',
            name = 'lowstalker',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/lowstalker.webp",
            category= 'Unmarked'
        },
        {
            label = 'Torrence',
            name = 'lowtorrence',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/lowtorrence.webp",
            category= 'Unmarked'
        },
        {
            label = 'Buffalo',
            name = 'lowbuff',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/lowbuff.webp",
            category= 'Unmarked'
        },
        {
            label = 'STX UMK',
            name = 'usumk1',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/usumk1.webp",
            category= 'Unmarked'
        },
        {
            label = 'Stanier UMK',
            name = 'usumk2',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/usumk2.webp",
            category= 'Unmarked'
        },
        {
            label = 'Buffalo S UMK',
            name = 'usumk3',
            image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/USSS/usumk3.webp",
            category= 'Unmarked'
        },
        
    },
}

function OpenMenuVehUsss()
    forceHideRadar()
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'MenuCatalogue',
        data = listVehUsss
    }))
end