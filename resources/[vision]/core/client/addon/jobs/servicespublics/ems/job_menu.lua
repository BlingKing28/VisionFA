local token = nil
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

CreateThread(function()
    while zone == nil do Wait(1)end

    local ped = entity:CreatePedLocal("s_m_m_armoured_02",vector3(1133.8875732422, -1580.0914306641, 33.864002227783),  15.44)
    ped:setFreeze(true)
    SetEntityInvincible(ped.id, true)
    SetEntityAsMissionEntity(ped.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped.id, true)

    local ped2 = entity:CreatePedLocal("s_m_m_armoured_02", vector3(1208.1646728516, -1487.5675048828, 33.842628479004),  15.44)
    ped2:setFreeze(true)
    SetEntityInvincible(ped2.id, true)
    SetEntityAsMissionEntity(ped2.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped2.id, true)

    --local ped3 = entity:CreatePedLocal("s_m_m_armoured_02", vector3(-805.943359375, -1497.4056396484, 0.5952172279358),  15.44)
    --ped3:setFreeze(true)
    --SetEntityInvincible(ped3.id, true)
    --SetEntityAsMissionEntity(ped3.id, 0, 0)
    --SetBlockingOfNonTemporaryEvents(ped3.id, true)

    --local ped4 = entity:CreatePedLocal("s_m_m_armoured_02", vector3(-273.34683227539, 6311.41015625, 31.398902893066), 311.19586181641)
    --ped4:setFreeze(true)
    --SetEntityInvincible(ped4.id, true)
    --SetEntityAsMissionEntity(ped4.id, 0, 0)
    --SetBlockingOfNonTemporaryEvents(ped4.id, true)

    --local ped5 = entity:CreatePedLocal("s_m_m_armoured_02", vector3(-254.83410644531, 6315.734375, 36.616020202637), 314.57843017578)
    --ped5:setFreeze(true)
    --SetEntityInvincible(ped5.id, true)
    --SetEntityAsMissionEntity(ped5.id, 0, 0)
    --SetBlockingOfNonTemporaryEvents(ped5.id, true)

    local ped6 = entity:CreatePedLocal("s_f_y_scrubs_01", vector3(1141.9243164063, -1529.9974365234, 34.03271484375), 45.66569213867)
    ped6:setFreeze(true)
    SetEntityInvincible(ped6.id, true)
    SetEntityAsMissionEntity(ped6.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped6.id, true)

end)

EmsDuty = false

function LoadEmsJob()

    ----Zone

    zone.addZone("pharmacie_ems", vector3(1141.9243164063, -1529.9974365234, 34.03271484375),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir la pharmacie", 
        function()
            OpenEMSITEMMenu()
        end, 
        false, -- Avoir un marker ou non
        -1, -- Id / type du marker
        0.6, -- La taille
        { 0, 0, 0 }, -- RGB
        0, -- Alpha
        2.5 -- Interact dist
    )
    zone.addZone("society_ems_custom", vector3(1220.9024658203, -1513.2397460938, 33.692890167236),
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
    --zone.addZone("society_ems2_custom", vector3(-1843.3579101563, -320.71841430664, 49.142948150635),
    --    "Appuyer sur ~INPUT_CONTEXT~ pour éditer votre vehicule",
    --    function()
    --        local veh = p:currentVeh()
    --        if GetVehicleClass(veh)== 18 then
    --           extraVeh(veh)
    --        else
    --           exports['vNotif']:createNotification({
    --              type = 'ROUGE',
    --              duration = 5, -- In seconds, default:  4
    --              content = "Ceci n'est ~s pas un véhicule de fonction"
    --             })     
    --        end
    --    end, true, 39, -- Id / type du marker
    --    0.5, -- La taille
    --    {203, 75, 0}, -- RGB
    --    170 -- Alpha
    --)

    local items = {
        headerImage = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Banners/SAMS.webp",
        headerIcon = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Banners/icon.webp',
        headerIconName = 'CATALOGUE',
        callbackName = 'pharmacyTakeEMS',
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
                image = "assets/inventory/items/pad2.png",
                name = "pad2",
                label = "Pansement Hello Kitty",
            },
        }
    }

    function OpenEMSITEMMenu()
        FreezeEntityPosition(PlayerPedId(), true)
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogueAchat',
            data = items
        }));
    end

    zone.addZone(
        "bateau_ems",
        vector3(-805.943359375, -1497.4056396484, 0.5952172279358),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage bateau",
        function()
            spawnMenuChoose = 'boat'
            openGarageSAMSBoatMenu() --TODO: fini le menu society
        end,
        false,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    zone.addZone(
        "delete_bateau_ems",
        vector3(-803.27239990234, -1500.1253662109, 1.11955547332764),
        "Appuyer sur ~INPUT_CONTEXT~ pour ranger le bateau",
        function()
            if IsPedInAnyVehicle(p:ped(), false) then
                local veh = GetVehiclePedIsIn(p:ped(), false)
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                DeleteEntity(veh)
            end
        end,
        true,
        35, -- Id / type du marker
        0.6, -- La taille
        { 255, 0, 0 }, -- RGB
        170-- Alpha
    )
    -- zone.addZone(
    --     "pharmacie_ems",
    --     vector3(-1830.7849121094, -381.51647949219, 48.402370452881),
    --     "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir la pharmacie",
    --     function()
    --         OpenEMSITEMMenu() --TODO: fini le menu society
    --     end,
    --     true,
    --     25, -- Id / type du marker
    --     0.6, -- La taille
    --     { 51, 204, 255 }, -- RGB
    --     170-- Alpha
    -- )
    zone.addZone(
        "society_ems",
        vector3(1117.8559570313, -1566.52734375, 38.503604888916),
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
        "coffre_pems",
        vector3(-1883.9176025391, -321.65606689453, 53.752689361572),
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
        "society_ems_delete",
        vector3(1147.7355957031, -1584.5443115234, 33.720581054688),
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
        "society_ems_delete2",
        vector3(1201.1782226563, -1494.1302490234, 33.692626953125),
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
        "society_emsHeli_delete",
        vector3(1179.6925048828, -1475.3151855469, 39.757480621338),
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
        "spawn_ems_heli",
        vector3(1181.7042236328, -1486.3112792969, 38.163154602051),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        function()
            spawnMenuChoose = 'heli'
            openGarageHeliSAMSMenu()
        end,
        false,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170--
    )

    zone.addZone(
        "spawn_ems_heli2",
        vector3(-254.83410644531, 6315.734375, 36.616020202637),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        function()
            spawnMenuChoose = 'heli'
            openGarageHeliSAMSMenu()
        end,
        false,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170--
    )

    zone.addZone(
        "society_emsHeli2_delete",
        vector3(-245.71530151367, 6323.3715820313, 37.616039276123),
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

    local listHeli = {
        headerImage = 'assets/EMS/header_sams.jpg',
        headerIcon = 'assets/EMS/logo_voiture.png',
        headerIconName = 'HELICOPTERES',
        callbackName= 'Menu_SAMS_heli_callback',
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

    function openGarageHeliSAMSMenu()
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogue',
            data = listHeli
        }))
    end



    zone.addZone(
        "spawn_ems",
        vector3(1133.8875732422, -1580.0914306641, 33.864002227783),
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

    zone.addZone(
        "spawn_ems2",
        vector3(1208.1646728516, -1487.5675048828, 33.842628479004),
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
    zone.addZone("ems_vest", vector3(1139.8210449219, -1538.0844726563, 34.032707214355),
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
            TriggerSecurGiveEvent("core:addItemToInventory", token, "outfit", 1, {renamed = "Tenue SAMS HOMME", data = tenueH})
        else
            TriggerSecurGiveEvent("core:addItemToInventory", token, "outfit", 1, {renamed = "Tenue SAMS FEMME", data = tenueF})
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
        vector3(1137.6646728516, -1540.900390625, 34.032707214355),
        --vector3(-1814.8516845703, -359.9665222168, 49.456581115723),
        --vector3(-1819.8349609375, -360.47152709961, 49.449405670166),
        --vector3(-1814.6741943359, -353.55563354492, 49.467071533203),
        --vector3(-1816.4432373047, -355.45855712891, 49.46178817749),
        --vector3(-1812.9456787109, -358.21035766602, 49.461769104004),

    }

    for k, v in pairs(coffrePos) do
        zone.addZone(
            "casier_ems" .. k,
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
        callbackName = 'Menu_SAMS_vehicule_callback',
        elements = {
            {
                id = 1,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/blazerems.webp',
                label = 'LSMS Quad',
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
                label = 'LSMS Speedo',
                name = "emsnspeedo"
            },
            {
                id = 4,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/emsstalker.webp',
                label = 'Stalker LSMS',
                name = "emsstalker"
            },
            {
                id = 5,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/samscara.webp',
                label = 'Caracara LSMS',
                name = "samscara"
            },
            {
                id = 6,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/lsfd3.webp',
                label = 'Ambulance LSMS',
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
    function SetEmsDuty()
        if EmsDuty then
            TriggerServerEvent('core:DutyOff', 'ems')
            --  ShowNotification("Vous avez ~r~quitté~s~ votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s quitté ~c votre service"
            })
            EmsDuty = false
            Wait(5000)
        else
            TriggerServerEvent('core:DutyOn', 'ems')
            --  ShowNotification("Vous avez ~r~quitté~s~ votre service")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s pris ~c votre service"
            })
            EmsDuty = true
            Wait(5000)
        end
    end

    function RenfortEms()
        if EmsDuty then
            openRadial = false
            closeUI()
            TriggerServerEvent('core:makeCall', "ems", p:pos(), false, "Besoin de renfort")
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function FactureEms(entity)
        if EmsDuty then
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

    function HealthPatientSAMS()
        if EmsDuty then
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
        if EmsDuty then
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
        if EmsDuty then
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
        if EmsDuty then
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
                                action = "OpenMainRadialSAMS"
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
                                action = "OpenPropsMenuSAMS"
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
                                action = "HealthPatientSAMS"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenMainRadialSAMS"
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

                function OpenMainRadialSAMS()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "APPEL DE RENFORT",
                                icon = "assets/svg/radial/pharmacy.svg",
                                action = "RenfortEms"
                            }, 
                            {
                                name = "PAPIERS",
                                icon = "assets/svg/radial/bpm.svg",
                                action = "OpenSubRadialPapiers"
                            },
                            {
                                name = "PRISE DE SERVICE",
                                icon = "assets/svg/radial/checkmark.svg",
                                action = "SetEmsDuty"
                            },
                            {
                                name = "SOINS",
                                icon = "assets/svg/radial/health.svg",
                                action = "OpenSubRadialSoins"
                            }
                        }, title = "SAMS"}
                    }));
                end

                OpenMainRadialSAMS()
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
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Cones/"..i..".webp",
                category="Cones", 
                label = "#"..i
            })
        end


        -- Panneaux
        for i = 1, 5 do
            table.insert(DataSendPropsSAMS.items[3].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Panneaux/"..i..".webp",
                category="Panneaux",
                label = "#"..i
            })
        end

        -- Barrière
        for i = 1, 9 do
            table.insert(DataSendPropsSAMS.items[4].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Barrieres/"..i..".webp",
                category="Barrières",
                label = "#"..i
            })
        end

        -- Lumières
        for i = 1, 5 do
            table.insert(DataSendPropsSAMS.items[5].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Lumieres/"..i..".webp",
                category="Lumières",
                label = "#"..i
            })
        end

        -- Tables
        for i = 1, 2 do
            table.insert(DataSendPropsSAMS.items[6].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Tables/"..i..".webp",
                category="Tables",
                label = "#"..i
            })
        end

        -- Divers
        for i = 1, 8 do
            table.insert(DataSendPropsSAMS.items[7].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Divers/"..i..".webp",
                category="Divers",
                label = "#"..i
            })
        end

        -- Sacs
        for i = 1, 2 do
            table.insert(DataSendPropsSAMS.items[8].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Sacs/"..i..".webp",
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
        headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/EMS/header_sams.webp',
        callbackName = 'MenuObjetsServicesPublicsSAMS',
        showTurnAroundButtons = false,
    }

    local firstart = false

    function OpenPropsMenuSAMS()
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
        PropsMenu.open = true
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuObjetsServicesPublics',
            data = DataSendPropsSAMS
        }))
    end


end

function UnLoadEmsJob()
    zone.removeZone("society_ems")
    zone.removeZone("coffre_pems")
    zone.removeZone("vestiare_pems")
    zone.removeZone("ems_vest")
    zone.removeZone("society_ems_delete")
    zone.removeZone("society_ems_delete2")
    zone.removeZone("society_emsHeli_delete")
    zone.removeZone("spawn_ems_heli")
    zone.removeZone("society_emsHeli2_delete")
    zone.removeZone("spawn_ems_heli2")
    zone.removeZone("spawn_ems")
    zone.removeZone("spawn_ems2")
end

RegisterNUICallback("Menu_SAMS_vehicule_callback", function (data, cb)
    local premierSpawn = GetDistanceBetweenCoords(1133.8875732422, -1580.0914306641, 33.864002227783, GetEntityCoords(PlayerPedId()))
    if premierSpawn < 3.5 then
        if vehicle.IsSpawnPointClear(vector3(1130.6845703125, -1585.0247802734, 33.720584869385), 5.0) then
            vehs = vehicle.create(data.name, vector4(1130.6845703125, -1585.0247802734, 33.720584869385, 267.71655273438), {})
            SetVehicleMod(vehs, 11, 1, false)
            SetVehicleMod(vehs, 13, 1, false)
            if data.label == "Ambulance LSMS" then
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
            if vehicle.IsSpawnPointClear(vector3(1130.6541748047, -1587.9205322266, 33.720584869385), 3.0) then
                vehs = vehicle.create(data.name, vector4(1130.6541748047, -1587.9205322266, 33.720584869385, 267.67672729492), {})
                SetVehicleMod(vehs, 11, 1, false)
                SetVehicleMod(vehs, 13, 1, false)
                if data.label == "Ambulance LSMS" then
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
        end
    else
        if vehicle.IsSpawnPointClear(vector3(1201.1782226563, -1494.1302490234, 33.692626953125), 3.0) then
            vehs = vehicle.create(data.name, vector4(1201.1782226563, -1494.1302490234, 33.692626953125, 179.34599304199), {})
            SetVehicleMod(vehs, 11, 1, false)
            SetVehicleMod(vehs, 13, 1, false)
            if data.label == "Ambulance LSMS" then
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
    end
end)

RegisterNUICallback("Menu_SAMS_heli_callback", function (data, cb)
    print(json.encode(data))
    local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1179.6925048828, -1475.3151855469, 39.757480621338)
    if distance < 50.0 then
        if vehicle.IsSpawnPointClear(vector3(1179.6925048828, -1475.3151855469, 39.757480621338), 3.0) then
            vehs = vehicle.create(data.spawnName, vector4(1179.6925048828, -1475.3151855469, 39.757480621338, 184.68119812012), {})
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
    else
        if vehicle.IsSpawnPointClear(vector3(-1865.9111328125, -350.69891357422, 57.098575592041), 3.0) then
            vehs = vehicle.create(data.spawnName, vector4(-1865.9111328125, -350.69891357422, 57.098575592041, 319.50329589844), {})
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
    end
end)

RegisterNUICallback("Menu_SAMS_boat_callback", function (data, cb)
    if vehicle.IsSpawnPointClear(vector3(-801.99151611328, -1500.0753173828, -0.47385582327843), 3.0) then
        vehs = vehicle.create(data.spawnName, vector4(-801.99151611328, -1500.0753173828, -0.47385582327843, 108.33866882324), {})
        if data.spawnName == 'emsseashark' then
            SetVehicleLivery(vehs, 0)
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

RegisterNUICallback("pharmacyTakeEMS", function(data, cb)
    print(json.encode(data))
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


PropsMenu = {
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
    if PropsMenu.open then
        PropsMenu.open = false 
    end
end)

RegisterNUICallback("MenuObjetsServicesPublicsSAMS", function(data, cb)
    -- if data == nil or data.category == nil then return end
    -- PropsMenu.choice = data.category

    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))

    if data.category == "Cones" then 
        print(data.label)
        
        SpawnPropsSAMS(cones_models[data.label], data.label)
    end
    
    if data.category == "Panneaux" then 
        print(data.label)
    
        SpawnPropsSAMS(panneaux_models[data.label], data.label)
    end

    if data.category == "Barrières" then 
        print(data.label)

        SpawnPropsSAMS(barriere_models[data.label], data.label)
    end

    if data.category == "Lumières" then 
        print(data.label)

        SpawnPropsSAMS(lumiere_models[data.label], data.label)
    end

    if data.category == "Tables" then 
        print(data.label)

        
        SpawnPropsSAMS(tables_models[data.label], data.label)
    end

    if data.category == "Divers" then 
        print(data.label)

        
        SpawnPropsSAMS(divers_models[data.label], data.label)
    end

    if data.category == "Sacs" then 
        print(data.label)

        
        SpawnPropsSAMS(sacs_models[data.label], data.label)
    end

end)


local SAMSPropsPlaced = {}

function SpawnPropsSAMS(obj, name)
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

            OpenPropsMenuSAMS()
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