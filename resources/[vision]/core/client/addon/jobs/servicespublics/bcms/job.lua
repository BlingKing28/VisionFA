local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

CreateThread(function()
    while zone == nil do Wait(1) end
    while entity == nil do Wait(1) end

    local ped6 = entity:CreatePedLocal("s_f_y_scrubs_01", vector3(-253.31239318848, 6321.595703125, 31.451961517334), 45.66569213867)
    ped6:setFreeze(true)
    SetEntityInvincible(ped6.id, true)
    SetEntityAsMissionEntity(ped6.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped6.id, true)

    local ped2 = entity:CreatePedLocal("s_m_m_armoured_02", vector3(-274.40087890625, 6311.4565429688, 31.48632),316.04809570313)
    ped2:setFreeze(true)
    SetEntityInvincible(ped2.id, true)
    SetEntityAsMissionEntity(ped2.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped2.id, true)

    local ped3 = entity:CreatePedLocal("s_m_m_armoured_02", vector3(-254.29682922363, 6315.9135742188, 36.61605072),315.04809570313)
    ped3:setFreeze(true)
    SetEntityInvincible(ped3.id, true)
    SetEntityAsMissionEntity(ped3.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped3.id, true)    
end)

BCMSDuty = false

function LoadBcmsJob()

    ----Zone

    zone.addZone("pharmacie_bcms", vector3(-253.31239318848, 6321.595703125, 31.451961517334),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir la pharmacie", 
        function()
            OpenbcmsITEMMenu()
        end, 
        false, -- Avoir un marker ou non
        -1, -- Id / type du marker
        0.6, -- La taille
        { 0, 0, 0 }, -- RGB
        0, -- Alpha
        2.5 -- Interact dist
    )
    zone.addZone("society_bcms_custom", vector3(-277.68853759766, 6327.279296875, 32.427120208727),
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
        end, true, 39, -- Id / type du marker
        0.5, -- La taille
        {203, 75, 0}, -- RGB
        170 -- Alpha
    )

    local items = {
        headerImage = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Banners/SAMS.webp",
        headerIcon = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Banners/icon.webp',
        headerIconName = 'CATALOGUE',
        callbackName = 'pharmacyTakeBCMS',
        showTurnAroundButtons = false,
        multipleSelection = true,
        elements = {
            {
                id = 1,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/bandages.webp",
                name = "band",
                label = "Bandages",
            },    
            {
                id = 2,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Jumelles.webp",
                name = "jumelle",
                label = "Jumelles",
            },
            {
                id = 3,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/medicament.webp",
                name = "medic",
                label = "Médicament",
            },
            {
                id = 4,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/medikit.webp",
                name = "medikit",
                label = "Medikit",
            },
            {
                id = 5,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Pansement.webp",
                name = "pad",
                label = "Pansement",
            },
            {
                id = 6,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/bequille.webp",
                name = "bequille",
                label = "Bequille",
            },
            {
                id = 7,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/wheelchair.webp",
                name = "froulant",
                label = "Chaise Roulante",
            },
            {
                id = 8,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/samskev.webp",
                name = "samskev",
                label = "Kevlar Class C",
            },
            {
                id = 9,
                image = "assets/inventory/items/poudre.png",
                name = "poudre",
                label = "Kit test de poudre",
            },
            {
                id = 10,
                image = "assets/inventory/items/pad3.png",
                name = "pad3",
                label = "Pansement Bob L'éponge",
            },
        }
    }

    function OpenbcmsITEMMenu()
        FreezeEntityPosition(PlayerPedId(), true)
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogueAchat',
            data = items
        }));
    end

    --zone.addZone(
    --    "bateau_bcms",
    --    vector3(-805.943359375, -1497.4056396484, 0.5952172279358),
    --    "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage bateau",
    --    function()
    --        spawnMenuChoose = 'boat'
    --        openGarageSAMSBoatMenu() --TODO: fini le menu society
    --    end,
    --    false,
    --    25, -- Id / type du marker
    --    0.6, -- La taille
    --    { 51, 204, 255 }, -- RGB
    --    170-- Alpha
    --)
    --zone.addZone(
    --    "delete_bateau_bcms",
    --    vector3(-803.27239990234, -1500.1253662109, 1.11955547332764),
    --    "Appuyer sur ~INPUT_CONTEXT~ pour ranger le bateau",
    --    function()
    --        if IsPedInAnyVehicle(p:ped(), false) then
    --            local veh = GetVehiclePedIsIn(p:ped(), false)
    --            TriggerEvent('persistent-vehicles/forget-vehicle', veh)
    --            removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
    --            TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
    --            DeleteEntity(veh)
    --        end
    --    end,
    --    true,
    --    35, -- Id / type du marker
    --    0.6, -- La taille
    --    { 255, 0, 0 }, -- RGB
    --    170-- Alpha
    --)
    zone.addZone(
        "society_bcms",
        vector3(-250.46115112305, 6323.1665039063, 31.451969146729),
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
        "coffre_bcms",
        vector3(-262.10620117188, 6323.36328125, 31.451965332031),
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
        "society_bcms_delete",
        vector3(-271.79919433594, 6313.5556640625, 32.360198974609),
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
        36, 0.5, { 255, 0, 0 }, 255
    )
    zone.addZone(
        "society_bcmsHeli_delete",
        vector3(-245.8053894043, 6323.357421875, 36.616050720215),
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
        36, 0.5, { 255, 0, 0 }, 255, 7
    )
    zone.addZone(
        "spawn_bcms_heli",
        vector3(-254.29682922363, 6315.9135742188, 36.616050720215),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        function()
            spawnMenuChoose = 'heli'
            openGarageHeliBCMSMenu()
        end,
        false,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170--
    )

    local listHeli = {
        headerImage = 'assets/EMS/header_bcms.png',
        headerIcon = 'assets/EMS/logo_voiture.png',
        headerIconName = 'HELICOPTERES',
        callbackName= 'Menu_BCMS_heli_callback',
        elements = {
            {
                label = 'Swift',
                spawnName = 'EMSSWIFT',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/emsswift.webp",
            },
            {
                label = 'Maverick',
                spawnName = 'lspdmav',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/lspdmav.webp",
            },
        }
    }

    function openGarageHeliBCMSMenu()
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogue',
            data = listHeli
        }))
    end



    zone.addZone(
        "spawn_bcms",
        vector3(-274.40087890625, 6311.4565429688, 31.486328125),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        function()
            spawnMenuChoose = 'car'
            OpenMenuVehEms() 
        end,
        false,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    -- DEV
    zone.addZone("bcms_vest", vector3(-259.2473449707, 6323.0434570313, 31.45196914672),
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir", 
        function()
            LoadSAMSVestiaire()
        end,
        true, -- Avoir un marker ou non
        -1, -- Id / type du marker
        0.6, -- La taille
        { 0, 0, 0 }, -- RGB
        0, -- Alpha
        2.5 -- Interact dist
    )  

    local tenueH = {
        ['tshirt_1'] = 263,  ['tshirt_2'] = 0,

        ['torso_1'] = 518, ['torso_2'] = 6,

        ['arms'] = 11, ['arms_2'] = 0,

        ['pants_1'] = 191, ['pants_2'] = 0,

        ['shoes_1'] = 25, ['shoes_2'] = 0,
    }
    local tenueF = {
        ['tshirt_1'] = 265,  ['tshirt_2'] = 0,

        ['torso_1'] = 562, ['torso_2'] = 6,

        ['arms'] = 9, ['arms_2'] = 0,

        ['pants_1'] = 195, ['pants_2'] = 0,

        ['shoes_1'] = 25, ['shoes_2'] = 0,
        
        ['chain_1'] = 162, ['chain_2'] = 0,
    }
    --[[function EMSVestiaireDev()
        exports['vNotif']:createNotification({
            type = 'JAUNE',
            content = "Vous venez de récupérer votre tenue"
        })
        
        if p:isMale() then
            TriggerSecurGiveEvent("core:addItemToInventory", token, "outfit", 1, {renamed = "Tenue BCMS HOMME", data = tenueH})
        else
            TriggerSecurGiveEvent("core:addItemToInventory", token, "outfit", 1, {renamed = "Tenue BCMS FEMME", data = tenueF})
        end
    end ]]

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
                        for k, v in pairs(ems.outfit) do
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

    local coffrePos = {
        vector3(-1817.1107177734, -358.48999023438, 49.456157684326),
        vector3(-1814.8516845703, -359.9665222168, 49.456581115723),
        vector3(-1819.8349609375, -360.47152709961, 49.449405670166),
        vector3(-1814.6741943359, -353.55563354492, 49.467071533203),
        vector3(-1816.4432373047, -355.45855712891, 49.46178817749),
        vector3(-1812.9456787109, -358.21035766602, 49.461769104004),

    }

    for k, v in pairs(coffrePos) do
        zone.addZone(
            "casier_bcms" .. k,
            v,
            "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les casiers",
            function()
                OpenEMSCasier() --TODO: fini le menu society
            end,
            false,
            25, -- Id / type du marker
            0.6, -- La taille
            { 51, 204, 255 }, -- RGB
            170-- Alpha
        )
    end

    local casierOpen = false
    function OpenEMSCasier()
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
        -- OpenInventorySocietyMenu()
    end)

    local emsVeh = {
        headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_sams.webp',
        headerIcon = 'assets/icons/voiture-icon.png',
        headerIconName = 'VEHICULES',
        callbackName = 'Menu_BCMS_vehicule_callback',
        elements = {
            {
                id = 1,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/blazerems.webp',
                label = 'BCMS Quad',
                name = "blazerems"
            },
            {
                id = 2,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/ambulance4.webp',
                label = 'Ambulance',
                name = "ambulance4"
            },
            {
                id = 3,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/emsnspeedo.webp',
                label = 'BCMS Speedo',
                name = "emsnspeedo"
            },
            {
                id = 4,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/emsstalker.webp',
                label = 'Stalker BCMS',
                name = "emsstalker"
            },
            {
                id = 5,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/samscara.webp',
                label = 'Caracara BCMS',
                name = "samscara"
            },
            {
                id = 6,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/lsfd3.webp',
                label = 'Ambulance BCMS',
                name = "lsfd3"
            },
            {
                id = 7,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/lsfd3tems.webp',
                label = 'Ambulance TEMS',
                name = "lsfd3"
            },
            {
                id = 8,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/ems2stx.webp',
                label = 'Buffalo STX',
                name = "ems2stx"
            },
            {
                id = 9,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/emsbike.webp',
                label = 'Vélo',
                name = "emsbike"
            },
        }
    }

    function OpenMenuVehEms()
            forceHideRadar()
            SendNuiMessage(json.encode({
                type = 'openWebview',
                name = 'MenuCatalogue',
                data = emsVeh
            }))
        end

    local listBoat = {
        headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_sams.webp',
        headerIcon = 'assets/icons/voiture-icon.png',
        headerIconName = 'BATEAUX',
        callbackName = 'Menu_SAMS_boat_callback',
        elements = {
            {
                label = 'Jet-ski',
                spawnName = 'emsseashark',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/emsseashark.webp",
                category= 'Division',
                subCategory= 'Marina'
            },
            {
                label = 'Dinghy',
                spawnName = 'poldinghy',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/poldinghy.webp",
                category= 'Division',
                subCategory= 'Marina'
            },
        }
    }

    function openGarageSAMSBoatMenu()
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogue',
            data = listBoat
        }))
    end

    RegisterNUICallback("focusOut", function (data, cb)
        TriggerScreenblurFadeOut(0.5)
        DisplayHud(true)
        openRadarProperly()
    end)

    local openRadial = false
    function SetBCMSDuty()
        if BCMSDuty then
            TriggerServerEvent('core:DutyOff', 'bcms')
            --  ShowNotification("Vous avez ~r~quitté~s~ votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s quitté ~c votre service"
            })
            BCMSDuty = false
            Wait(5000)
        else
            TriggerServerEvent('core:DutyOn', 'bcms')
            --  ShowNotification("Vous avez ~r~quitté~s~ votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s pris ~c votre service"
            })
            BCMSDuty = true
            Wait(5000)
        end
    end

    function RenfortBCMS()
        if BCMSDuty then
            openRadial = false
            closeUI()
            TriggerServerEvent('core:makeCall', "bcms", p:pos(), false, "Besoin de renfort")
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function FactureEms(entity)
        if BCMSDuty then
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

    local open = false
    local outifitmenu = RageUI.CreateMenu("", "EMS", 0.0, 0.0, "vision", "menu_title_ems")
    local outfitmenu_list = RageUI.CreateSubMenu(outifitmenu, "", "EMS", 0.0, 0.0, "vision", "menu_title_ems")
    outifitmenu.Closed = function()
        open = false
    end

    local selected_table = {}

    function openOutfitMenu()
        if open then
            open = false
            RageUI.Visible(outifitmenu, false)
        else
            open = true
            RageUI.Visible(outifitmenu, true)

            Citizen.CreateThread(function()
                while open do
                    RageUI.IsVisible(outifitmenu, function()
                        for k, v in pairs(ems.outfit) do
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

    --[[local outfit = {
        vector3(-1817.7576904297, -361.52426147461, 49.450511932373),
        vector3(-1812.4222412109, -355.35546875, 49.466976165771),
    }
    for k, v in pairs(outfit) do
        zone.addZone(
            "ems.Outfit" .. math.random(0, 156465654),
            v,
            "Appuyer sur ~INPUT_CONTEXT~ pour interagir",
            function()
                openOutfitMenu()
            end,
            false
        )
    end]]

    function HealthPatientBCMS()
        if BCMSDuty then
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
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous n'êtes ~s pas en service"
            })
        end
    end

    function CertificatSAMS()
        if BCMSDuty then
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

    function CreateAdvert()
        if BCMSDuty then
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

    function RevivePatientSAMS()
        if BCMSDuty then
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

    function OpenRadialEmsMenu()
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
                                name = "ANNONCE",
                                icon = "assets/svg/radial/megaphone.svg",
                                action = "CreateAdvert"
                            },
                            {
                                name = "FACTURE",
                                icon = "assets/svg/radial/billet.svg",
                                action = "FactureEms"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenMainRadialBCMS"
                            },
                            {
                                name = "CERTIFICAT",
                                icon = "assets/svg/radial/health_paper.svg",
                                action = "CertificatSAMS"
                            }
                        }, 
                        title = "PAPIERS",
                        }
                    }));
                end

                function OpenSubRadialObject()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "OBJETS",
                                icon = "assets/svg/radial/object.svg",
                                action = "OpenPropsMenuBCMS"
                            },
                            {
                                name = "BRANCARD",
                                icon = "assets/svg/radial/health_tool.svg",
                                action = "Spawnbrancard"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenSubRadialSoins"
                            }
                        }, 
                        title = "SOINS",
                        }
                    }));
                end

                function OpenSubRadialSoins()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "OBJETS",
                                icon = "assets/svg/radial/object.svg",
                                action = "OpenSubRadialObject"
                            },
                            {
                                name = "SOIGNER",
                                icon = "assets/svg/radial/health_tool.svg",
                                action = "HealthPatientBCMS"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenMainRadialBCMS"
                            },
                            {
                                name = "REANIMER",
                                icon = "assets/svg/radial/heart.svg",
                                action = "RevivePatientSAMS"
                            }
                        }, 
                        title = "SOINS",
                        }
                    }));
                end

                function OpenMainRadialBCMS()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "APPEL DE RENFORT",
                                icon = "assets/svg/radial/pharmacy.svg",
                                action = "RenfortBCMS"
                            }, 
                            {
                                name = "PAPIERS",
                                icon = "assets/svg/radial/bpm.svg",
                                action = "OpenSubRadialPapiers"
                            },
                            {
                                name = "PRISE DE SERVICE",
                                icon = "assets/svg/radial/checkmark.svg",
                                action = "SetBCMSDuty"
                            },
                            {
                                name = "SOINS",
                                icon = "assets/svg/radial/health.svg",
                                action = "OpenSubRadialSoins"
                            }
                        }, title = "BCMS"}
                    }));
                end

                OpenMainRadialBCMS()
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

    RegisterJobMenu(OpenRadialEmsMenu)

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


    local function GetDatasPropsSAMS()
        -- DataSendPropsSAMS.items.elements = {}

        playerJobs = 'lsfd-sams'

        -- Cones
        for i = 1, 7 do
            table.insert(DataSendPropsSAMS.items[2].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenuBC/"..playerJobs.."/Cones/"..i..".webp",
                category="Cones", 
                label = "#"..i
            })
        end


        -- Panneaux
        for i = 1, 5 do
            table.insert(DataSendPropsSAMS.items[3].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenuBC/"..playerJobs.."/Panneaux/"..i..".webp",
                category="Panneaux",
                label = "#"..i
            })
        end

        -- Barrière
        for i = 1, 9 do
            table.insert(DataSendPropsSAMS.items[4].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenuBC/"..playerJobs.."/Barrieres/"..i..".webp",
                category="Barrières",
                label = "#"..i
            })
        end

        -- Lumières
        for i = 1, 5 do
            table.insert(DataSendPropsSAMS.items[5].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenuBC/"..playerJobs.."/Lumieres/"..i..".webp",
                category="Lumières",
                label = "#"..i
            })
        end

        -- Tables
        for i = 1, 2 do
            table.insert(DataSendPropsSAMS.items[6].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenuBC/"..playerJobs.."/Tables/"..i..".webp",
                category="Tables",
                label = "#"..i
            })
        end

        -- Divers
        for i = 1, 8 do
            table.insert(DataSendPropsSAMS.items[7].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenuBC/"..playerJobs.."/Divers/"..i..".webp",
                category="Divers",
                label = "#"..i
            })
        end

        -- Sacs
        for i = 1, 2 do
            table.insert(DataSendPropsSAMS.items[8].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenuBC/"..playerJobs.."/Sacs/"..i..".webp",
                category="Sacs",
                label = "#"..i
            })
        end


        DataSendPropsSAMS.disableSubmit = true

        return true
    end

    DataSendPropsSAMS = {
        items = {
            {   
                name = 'main',
                type = 'buttons',
                elements = {
                    {
                        name = 'Cones',
                        width = 'full',
                        image = 'assets/PropsMenuBC/cones.svg',
                        hoverStyle = ' stroke-black'
                    },
                    {
                        name = 'Panneaux',
                        width = 'full',
                        image = 'assets/PropsMenuBC/roadsign.svg',
                        hoverStyle = ' stroke-black'
                    },
                    {
                        name = 'Barrières',
                        width = 'full',
                        image = 'assets/PropsMenuBC/barriere.svg',
                        hoverStyle = ' stroke-black'
                    },
                    {
                        name = 'Lumières',
                        width = 'full',
                        image = 'assets/PropsMenuBC/light.svg',
                        hoverStyle = ' stroke-black'
                    },
                    {
                        name = 'Tables',
                        width = 'full',
                        image = 'assets/PropsMenuBC/table.svg',
                        hoverStyle = ' stroke-black'
                    },
                    {
                        name = 'Divers',
                        width = 'full',
                        image = 'assets/PropsMenuBC/divers.svg',
                        hoverStyle = ' stroke-black'
                    },
                    {
                        name = 'Sacs',
                        width = 'full',
                        image = 'assets/PropsMenuBC/sacs.svg',
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
        headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/header_sams.webp',
        callbackName = 'MenuObjetsServicesPublicsBCMS',
        showTurnAroundButtons = false,
    }

    local firstart = false

    function OpenPropsMenuBCMS()
        if firstart == false then
            firstart = true 
            local bool = GetDatasPropsSAMS()
            while not bool do 
                Wait(1)
            end
        end
        SendNuiMessage(json.encode({
            type = 'closeWebview',
        }))
        Wait(50)
        PropsMenuBC.open = true
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuObjetsServicesPublics',
            data = DataSendPropsSAMS
        }))
    end


end

function UnLoadBcmsJob()
    zone.removeZone("society_bcms")
    zone.removeZone("coffre_bcms")
    zone.removeZone("bcms_vest")
    zone.removeZone("society_bcms_delete")
    zone.removeZone("society_bcmsHeli_delete")
    zone.removeZone("spawn_bcms_heli")
    zone.removeZone("spawn_bcms")
end

RegisterNUICallback("Menu_BCMS_vehicule_callback", function (data, cb)
    if vehicle.IsSpawnPointClear(vector3(-271.79919433594, 6313.5556640625, 31.360198974609), 5.0) then
        vehs = vehicle.create(data.name, vector4(-271.79919433594, 6313.5556640625, 31.360198974609, 221.59736633301), {})
        SetVehicleMod(vehs, 11, 1, false)
        SetVehicleMod(vehs, 13, 1, false)
        if data.label == "Ambulance BCMS" then
            SetVehicleLivery(vehs, 1)
        elseif data.label == "Ambulance TEMS" then
            SetVehicleLivery(vehs, 2)
        elseif data.name == "samscara" then
            SetVehicleLivery(vehs, 1)
        elseif data.name == 'emsstalker' then
            SetVehicleLivery(vehs, 0)
        elseif data.name == 'ems2stx' then
            SetVehicleLivery(vehs, 1)
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

RegisterNUICallback("Menu_BCMS_heli_callback", function (data, cb)
    if vehicle.IsSpawnPointClear(vector3(-245.83056640625, 6323.298828125, 36.616050720215), 3.0) then
        vehs = vehicle.create(data.spawnName, vector4(-245.83056640625, 6323.298828125, 36.616050720215, 316.78823852539), {})
        -- SetVehicleLivery(vehs, 0)
        if data.spawnName == 'EMSSWIFT' then
            SetVehicleLivery(vehs, 0)
        elseif data.spawnName == 'lspdmav' then
            SetVehicleLivery(vehs, 3)
        else
            SetVehicleLivery(vehs, 1)
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

RegisterNUICallback("pharmacyTakeBCMS", function(data, cb)
    for k, v in pairs(data) do
        print(v.name)
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


PropsMenuBC = {
    cam = nil,
    open = false,
}

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
    ['#8']     = "treasurechest",
}

local sacs_models = {
    ['#1']     = "xm_prop_x17_bag_01c",
    ['#2']     = "xm_prop_x17_bag_med_01a",
}


RegisterNUICallback("focusOut", function()
    if PropsMenuBC.open then
        PropsMenuBC.open = false 
    end
end)

RegisterNUICallback("MenuObjetsServicesPublicsBCMS", function(data, cb)
    -- if data == nil or data.category == nil then return end
    -- PropsMenuBC.choice = data.category

    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))

    if data.category == "Cones" then 
        print(data.label)
        
        SpawnPropsBCMS(cones_models[data.label], data.label)
    end
    
    if data.category == "Panneaux" then 
        print(data.label)
    
        SpawnPropsBCMS(panneaux_models[data.label], data.label)
    end

    if data.category == "Barrières" then 
        print(data.label)

        SpawnPropsBCMS(barriere_models[data.label], data.label)
    end

    if data.category == "Lumières" then 
        print(data.label)

        SpawnPropsBCMS(lumiere_models[data.label], data.label)
    end

    if data.category == "Tables" then 
        print(data.label)

        
        SpawnPropsBCMS(tables_models[data.label], data.label)
    end

    if data.category == "Divers" then 
        print(data.label)

        
        SpawnPropsBCMS(divers_models[data.label], data.label)
    end

    if data.category == "Sacs" then 
        print(data.label)

        
        SpawnPropsBCMS(sacs_models[data.label], data.label)
    end

end)


local SAMSPropsPlaced = {}

function SpawnPropsBCMS(obj, name)
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

            OpenPropsMenuBCMS()
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
    table.insert(SAMSPropsPlaced, {
        nom = name,
        prop = objS.id
    })
end