local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local posSS = { 
vector4(1846.1009521484, 3683.0422363281, 33.015636444092, 210.47543334961),
vector4(1848.8779296875, 3684.3435058594, 32.991184234619, 205.70333862305),
vector4(1851.5484619141, 3686.0888671875, 32.984485626221, 209.00559997559),
vector4(1854.1516113281, 3687.5639648438, 32.974479675293, 210.54666137695),
vector4(1856.7744140625, 3689.1391601563, 32.973510742188, 210.62004089355),
vector4(1859.4742431641, 3690.7448730469, 32.965492248535, 209.88619995117),
vector4(1862.0922851563, 3692.2785644531, 32.965557098389, 209.95959472656),
vector4(1870.0708007813, 3684.4592285156, 32.761756896973, 30.698202133179),
vector4(1867.5274658203, 3682.9943847656, 32.778057098389, 29.890981674194),
vector4(1864.7573242188, 3681.3703613281, 32.820789337158, 29.890981674194),
vector4(1853.1021728516, 3674.7277832031, 32.989971160889, 28.423355102539),
vector4(1850.5083007813, 3673.2827148438, 33.019504547119, 29.303928375244),
vector4(1847.8205566406, 3671.7395019531, 33.048400878906, 29.157163619995),
vector4(1845.1099853516, 3670.2104492188, 33.08517074585, 30.991661071777) 
}

local posPB = { 
vector4(-482.44570922852, 6024.583984375, 30.340375900269, 223.04058837891),
vector4(-478.29275512695, 6026.9252929688, 30.340375900269, 226.08567810059),
vector4(-475.24127197266, 6030.8276367188, 30.340375900269, 224.17758178711),
vector4(-471.88851928711, 6034.0708007813, 30.340375900269, 221.46240234375),
vector4(-468.21636962891, 6037.3647460938, 30.340375900269, 221.46240234375)
}

CreateThread(function()
    local ped = nil
    local ped2 = nil
    if not created then
        ped3 = entity:CreatePedLocal("s_m_y_sheriff_01", vector3(-462.71929931641, 6001.5576171875, 30.489170074463),
            136.33042907715)
        ped4 = entity:CreatePedLocal("s_m_y_sheriff_01", vector3(-462.72024536133, 6025.9243164063, 30.448970794678),
            136.35829162598)
        ped5 = entity:CreatePedLocal("s_m_y_sheriff_01", vector3(1453.0445556641, 3766.8862304688, 30.746339797974),
            298.91055297852)

        created = true
    end

    SetEntityInvincible(ped3.id, true)
    ped3:setFreeze(true)
    TaskStartScenarioInPlace(ped3.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
    SetEntityAsMissionEntity(ped3.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped3.id, true)

    SetEntityInvincible(ped4.id, true)
    ped4:setFreeze(true)
    TaskStartScenarioInPlace(ped4.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
    SetEntityAsMissionEntity(ped4.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped4.id, true)

    SetEntityInvincible(ped5.id, true)
    ped5:setFreeze(true)
    TaskStartScenarioInPlace(ped5.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
    SetEntityAsMissionEntity(ped5.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped5.id, true)
end)


lssdDuty = false

function LoadLssdJob()

    local casierPos = { 
        vector3(2806.1645507813, 4709.3530273438, 47.627368927002),
        vector3(2805.5173339844, 4711.6162109375, 47.627334594727),
        vector3(2802.2687988281, 4712.9516601563, 47.627361297607),
        vector3(2802.9243164063, 4709.3403320313, 47.627338409424),
        vector3(-1087.1840820313, -812.73260498047, 5.4792823791504),
        vector3(-1095.697265625, -824.0, 26.826816558838),
        vector3(-1098.9569091797, -827.09417724609, 26.826910018921) 
    }

    zone.addZone("society_lssd1", vector3(2784.7231445313, 4748.3232421875, 47.627365112305),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les actions d'entreprise", function()
            OpenSocietyMenu() -- TODO: fini le menu society
        end, false, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    zone.addZone(
        "society_lssd_custom",
        vector3(2820.3325195313, 4828.01171875, 47.182415008545),
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
        "society_lssd2_custom",
        vector3(-479.3137512207, 6028.4067382813, 31.340391159058),
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

    zone.addZone("society_lssd2", vector3(-432.72622680664, 6005.9731445313, 36.995658874512),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les actions d'entreprise", function()
            OpenSocietyMenu() -- TODO: fini le menu society
        end, false, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone("lssd_item", vector3(2809.1608886719, 4722.7626953125, 47.627319335938),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir l'armurerie ", 
        function()
            OpenLssdItemMenu()
        end,
        false, -- Avoir un marker ou non
        -1, -- Id / type du marker
        0.6, -- La taille
        { 0, 0, 0 }, -- RGB
        0, -- Alpha
        1.1 -- Interact dist
    )

    zone.addZone("lssd_item_2", vector3(-444.26174926758, 6013.662109375, 37.008354187012),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir l'armurerie ", 
        function()
            OpenLssdItemMenu()
        end,
        false, -- Avoir un marker ou non
        -1, -- Id / type du marker
        0.6, -- La taille
        { 0, 0, 0 }, -- RGB
        0, -- Alpha
        2.5 -- Interact dist
    )

    -- DEV
    zone.addZone("lssd_vest", vector3(2800.4301757813, 4707.025390625, 47.627372741699),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le vestiaire", 
        function()
            LSSDVestiaireDev()
        end,
        true, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone("lssd_vest_2", vector3(-438.67678833008, 6008.1904296875, 36.99567031860),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le vestiaire", 
        function()
            LSSDVestiaireDev()
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
                        for k, v in pairs(lssd.outfit) do
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

        headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Banners/LSSD.webp',
        headerIcon = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Banners/icon.webp',
        headerIconName = 'CATALOGUE',
        callbackName = 'armoryTakeLSSD',
        showTurnAroundButtons = false,
        multipleSelection = true,
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
                id = 1,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lssdshield.webp",
                name = "lssdshield",
                label = "Bouclier anti-émeute",
            },
            {            
                price = 0,
                id = 2,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/weapon_fireextinguisher.webp",
                name = "weapon_fireextinguisher",
                label = "Extincteur",
            },
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
            {         
                price = 0,
                id = 6,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lssdgiletj.webp",
                name = "lssdgiletj",
                label = "Gilet Jaune",
            },
            {            
                price = 0,
                id = 7,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lssdkevle1.webp",
                name = "lssdkevle1",
                label = "Kevlar Class A",
            },           
            {           
                price = 0,
                id = 8,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lssdkevlo1.webp",
                name = "lssdkevlo1",
                label = "Kevlar Class C 1",
            },
            {           
                price = 0,
                id = 9,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lssdkevlo2.webp",
                name = "lssdkevlo2",
                label = "Kevlar Class C 2",
            },
            {           
                price = 0,
                id = 10,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lssdkevlo3.webp",
                name = "lssdkevlo3",
                label = "Kevlar Class C 3",
            },
            {           
                price = 0,
                id = 11,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lssdkevlo4.webp",
                name = "lssdkevlo4",
                label = "Kevlar Class C 4",
            },
            {           
                price = 0,
                id = 12,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lssdinsigne.webp",
                name = "lssdinsigne",
                label = "LSSD - Insigne",
            },
            {           
                price = 0,
                id = 13,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lssdriot.webp",
                name = "lssdriot",
                label = "Protection Anti Emeute",
            },
            {           
                price = 0,
                id = 14,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lssdkevle2.webp",
                name = "lssdkevle2",
                label = "Gilet Pare-Couteau",
            },
            {           
                price = 0,
                id = 15,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lssdkevlo5.webp",
                name = "lssdkevlo5",
                label = "Kevlar Class C 5",
            },
            {           
                price = 0,
                id = 16,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lssdkevlo6.webp",
                name = "lssdkevlo6",
                label = "Kevlar Class C 6",
            },
            {           
                price = 0,
                id = 17,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lssdkevlo7.webp",
                name = "lssdkevlo7",
                label = "Kevlar Class C 7",
            },
        },
    }
    function OpenLssdItemMenu()
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
    
    zone.addZone("stockage_lssd", vector3(2814.5180664063, 4724.8842773438, 47.627300262451),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le coffre des saisies", function()
            OpenInventorySocietyMenu() -- TODO: fini le menu society
        end, false, 25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    for k, v in pairs(casierPos) do
        zone.addZone("coffre_lssd" .. k, v, "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les casiers",
            function()
                OpenlspdCasier() -- TODO: fini le menu society
            end, false, 25, -- Id / type du marker
            0.6, -- La taille
            { 51, 204, 255 }, -- RGB
            170-- Alpha
        )
    end

    zone.addZone(
        "spawn_lssd_heli",
        vector3(2761.4479980469, 4834.5888671875, 46.371734619141),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        function()
            openGarageHeliLSSDMenu()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170--
    )

    zone.addZone(
        "society_lssdHeli_delete",
        vector3(2752.1892089844, 4850.8046875, 47.3717918396),
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
        36, 0.5, { 255, 0, 0 }, 255
    )

    zone.addZone(
        "spawn_lssd_heli2",
        vector3(-463.1799621582, 6000.970703125, 30.489166259766),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        function()
            openGarageHeliLSSDMenu()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170--
    )

    zone.addZone(
        "society_lssdHeli2_delete",
        vector3(-475.1667175293, 5988.453125, 31.336488723755),
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
        "spawn_lssd_boat",
        vector3(1453.8256835938, 3767.2709960938, 30.846427536011),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        function()
        openGarageLSSDBoatMenu()
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170--
    )
    zone.addZone(
        "society_lssdBoat_delete",
        vector3(1454.3397216797, 3772.1853027344, 28.974069595337),
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

    local openRadial = false

    local open = false
    local lspdmenu_objects = RageUI.CreateMenu("", "LSSD", 0.0, 0.0, "vision", "menu_title_police")
    local lspdmenu_traffic = RageUI.CreateMenu("", "LSSD", 0.0, 0.0, "vision", "menu_title_police")
    local lspdmenu_traffic_add = RageUI.CreateSubMenu(lspdmenu_traffic, "", "LSSD", 0.0, 0.0, "vision",
        "menu_title_police")
    local lspdmenu_traffic_view = RageUI.CreateSubMenu(lspdmenu_traffic, "", "LSSD", 0.0, 0.0, "vision",
        "menu_title_police")
    local lspdmenu_objects_delete = RageUI.CreateSubMenu(lspdmenu_objects, "", "LSSD", 0.0, 0.0, "vision",
        "menu_title_police")
    lspdmenu_objects.Closed = function()
        open = false
    end
    lspdmenu_traffic.Closed = function()
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
        if lssdDuty then
            openRadial = false
            closeUI()
            -- open a menu with 2 buttons : one to add a new zone and one to view my zones
            if open then
                open = false
                RageUI.Visible(lspdmenu_traffic, false)
            else
                open = true
                RageUI.Visible(lspdmenu_traffic, true)

                Citizen.CreateThread(function()
                    while open do
                        RageUI.IsVisible(lspdmenu_traffic, function()
                            -- for the first button to add a new zone, it opens a menu where i can set the speed in the zone and the radius of the zone, another checkbox to show it on my client and a last button to add the zone
                            RageUI.Button("Ajouter une zone", nil, { RightLabel = ">" }, true, {
                                onSelected = function()
                                    zonePos = p:pos()
                                end
                            }, lspdmenu_traffic_add)
                            -- for the second button to view my zones, it opens a menu where i can see all my zones and delete them
                            RageUI.Button("Voir les zones", nil, { RightLabel = ">" }, true, {
                                onSelected = function()
                                    traficList = TriggerServerCallback("lspd:traffic:get")
                                end
                            }, lspdmenu_traffic_view)
                        end)
                        RageUI.IsVisible(lspdmenu_traffic_add, function()
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
                                    radius = tonumber(KeyboardImput("Rayon"))  + .0
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
                                            duration = 5, -- In seconds, default:  4
                                            content = "~s Zone ajoutée"
                                        })
                                        open = false
                                        RageUI.CloseAll()
                                    else
                                        -- ShowNotification("~r~Veuillez remplir tous les champs")

                                        -- New notif
                                        exports['vNotif']:createNotification({
                                            type = 'ROUGE',
                                            duration = 5, -- In seconds, default:  4
                                            content = "~s Veuillez remplir tous les champs"
                                        })
                                    end
                                end
                            })
                        end)
                        RageUI.IsVisible(lspdmenu_traffic_view, function()
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
                                                duration = 5, -- In seconds, default:  4
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
                duration = 5, -- In seconds, default:  4
                content = "Vous n'êtes ~s pas en service"
            }) 
        end
    end

    function lssdActionDuty()
        openRadial = false
        closeUI()
        if lssdDuty then
            TriggerServerEvent('core:DutyOff', 'lssd')
--[[             ShowAdvancedNotification("Centrale", "~b~Dispatch", "Vous avez quitté votre service", "CHAR_CALL911",
                "CHAR_CALL911") ]]

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s quitté ~c votre service"
            })

            lssdDuty = false
            Wait(5000)
        else
            TriggerServerEvent('core:DutyOn', 'lssd')
--[[             ShowAdvancedNotification("Centrale", "~b~Dispatch", "Vous avez pris votre service", "CHAR_CALL911",
                "CHAR_CALL911") ]]
            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s pris ~c votre service"
            })

            lssdDuty = true
            Wait(5000)
        end
    end

    function FactureLSSD()
        if lssdDuty then
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
    
    function ConvocationLSSD()
        if lssdDuty then
            openRadial = false
            closeUI()
            TriggerEvent("nuiPapier:client:startCreation", 5, 'assets/entrepriseCarre/lssd.jpg')
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function DepositionLSSD()
        if lssdDuty then
            openRadial = false
            closeUI()
            TriggerEvent("nuiPapier:client:startCreation", 4, "assets/entrepriseCarre/lssd.jpg")
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function makeRenfortCall()
        if lssdDuty then
            TriggerServerEvent('core:makeCall', "lssd", p:pos(), false, "appel de renfort")
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
                duration = 5, -- In seconds, default:  4
                content = "Vous n'êtes ~s pas en service"
            }) 
        end
    end

    function CreateAdvert()
        if lssdDuty then
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

    Keys.Register("F2", "F2", "Faire un appel de renfort", function()
        makeRenfortCall()
    end)

    function OpenRadialLssdMenu()
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
                                action = "ConvocationLSSD"
                            },
                            {
                                name = "FACTURE",
                                icon = "assets/svg/radial/billet.svg",
                                action = "FactureLSSD"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenMainRadialLSSD"
                            },
                            {
                                name = "DEPOSITION",
                                icon = "assets/svg/radial/paper.svg",
                                action = "DepositionLSSD"
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
                                action = "OpenMainRadialLSSD"
                            },
                            {
                                name = "OBJETS",
                                icon = "assets/svg/radial/object.svg",
                                action = "OpenPropsMenuLSSD"
                            }
                        }, 
                        title = "ACTIONS",
                        }
                    }));
                end

                function OpenMainRadialLSSD()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "APPEL DE RENFORT",
                                icon = "assets/svg/radial/police_logo.svg",
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
                                action = "lssdActionDuty"
                            },
                            {
                                name = "ACTIONS",
                                icon = "assets/svg/radial/police.svg",
                                action = "OpenSubRadialActions"
                            }
                        }, title = "LSSD"}
                    }));
                end

                OpenMainRadialLSSD()
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

    RegisterJobMenu(OpenRadialLssdMenu)
    
    
    zone.addZone(
        "lssd_vehicule",
        vector3(2840.2780761719, 4767.3500976563, 46.3717918396),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        function()
            openLSSDGarageMenu()
            forceHideRadar()
        end,
        false,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    
    zone.addZone(
        "lssd_vehicule_delete", vector3(2840.8173828125, 4786.009765625, 47.171337127686),
        "Appuyer sur ~INPUT_CONTEXT~ pour rentrer dans le garage", function()
            if IsPedInAnyVehicle(p:ped(), false) then
                local veh = GetVehiclePedIsIn(p:ped(), false)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                DeleteEntity(veh)
            end
        end, true,
        36, 0.5, { 255, 0, 0 }, 255)

        

    zone.addZone(
        "lssd_vehicule2",
        vector3(-463.40292358398, 6025.1684570313, 30.340393066406),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        function()
            openLSSDGarageMenu()
            forceHideRadar()
        end,
        false,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    
    zone.addZone(
        "lssd_vehicule2_delete", vector3(-482.88162231445, 6024.9052734375, 31.340389251709),
        "Appuyer sur ~INPUT_CONTEXT~ pour rentrer dans le garage", function()
            if IsPedInAnyVehicle(p:ped(), false) then
                local veh = GetVehiclePedIsIn(p:ped(), false)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                DeleteEntity(veh)
            end
        end, true,
        36, 0.5, { 255, 0, 0 }, 255)



    local listVeh = {
        headerImage = 'assets/headers/header_lssd.jpg',
        headerIcon = './assets/LSPD/logo_vehicule.png',
        headerIconName = 'VEHICULE',
        callbackName= 'Menu_LSSD_vehicule_callback',
        elements = {
            {
                label = 'Stanier',
                spawnName = 'lssdstanier1',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriff.webp",
                category= 'Grade',
                subCategory= 'Trainee'
            },
            {
                label = 'Scout 2',
                spawnName = 'lssdscout2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscout.webp",
                category= 'Grade',
                subCategory= 'Trainee'
            },
            {
                label = 'Scout 3',
                spawnName = 'lssdscoutnew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscoutnew.webp",
                category= 'Grade',
                subCategory= 'Trainee'
            },
            {
                label = 'Fugitive',
                spawnName = 'sherifffug',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sherifffug.webp",
                category= 'Grade',
                subCategory= 'Trainee'
            },
            {
                label = 'Alamo',
                spawnName = 'lssdalamonew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffalamo.webp",
                category= 'Grade',
                subCategory= 'Trainee'
            },
            {
                label = 'Stanier',
                spawnName = 'lssdstanier1',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriff.webp",
                category= 'Grade',
                subCategory= 'Deputy'
            },
            {
                label = 'Scout 2',
                spawnName = 'lssdscout2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscout.webp",
                category= 'Grade',
                subCategory= 'Deputy'
            },
            {
                label = 'Scout 3',
                spawnName = 'lssdscoutnew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscoutnew.webp",
                category= 'Grade',
                subCategory= 'Deputy'
            },
            {
                label = 'Fugitive',
                spawnName = 'sherifffug',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sherifffug.webp",
                category= 'Grade',
                subCategory= 'Deputy'
            },
            {
                label = 'Alamo',
                spawnName = 'lssdalamonew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffalamo.webp",
                category= 'Grade',
                subCategory= 'Deputy'
            },
            {
                label = 'Stanier',
                spawnName = 'lssdstanier1',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriff.webp",
                category= 'Grade',
                subCategory= 'Deputy I'
            },
            {
                label = 'Scout 2',
                spawnName = 'lssdscout2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscout.webp",
                category= 'Grade',
                subCategory= 'Deputy I'
            },
            {
                label = 'Scout 3',
                spawnName = 'lssdscoutnew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscoutnew.webp",
                category= 'Grade',
                subCategory= 'Deputy I'
            },
            {
                label = 'Fugitive',
                spawnName = 'sherifffug',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sherifffug.webp",
                category= 'Grade',
                subCategory= 'Deputy I'
            },
            {
                label = 'Alamo',
                spawnName = 'lssdalamonew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffalamo.webp",
                category= 'Grade',
                subCategory= 'Deputy I'
            },
            {
                label = 'Stanier',
                spawnName = 'lssdstanier1',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriff.webp",
                category= 'Grade',
                subCategory= 'Deputy II'
            },
            {
                label = 'Scout 2',
                spawnName = 'lssdscout2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscout.webp",
                category= 'Grade',
                subCategory= 'Deputy II'
            },
            {
                label = 'Scout 3',
                spawnName = 'lssdscoutnew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscoutnew.webp",
                category= 'Grade',
                subCategory= 'Deputy II'
            },
            {
                label = 'Fugitive',
                spawnName = 'sherifffug',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sherifffug.webp",
                category= 'Grade',
                subCategory= 'Deputy II'
            },
            {
                label = 'Alamo',
                spawnName = 'lssdalamonew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffalamo.webp",
                category= 'Grade',
                subCategory= 'Deputy II'
            },
            {
                label = 'Stanier',
                spawnName = 'lssdstanier1',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriff.webp",
                category= 'Grade',
                subCategory= 'Senior Lead Deputy'
            },
            {
                label = 'Scout 2',
                spawnName = 'lssdscout2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscout.webp",
                category= 'Grade',
                subCategory= 'Senior Lead Deputy'
            },
            {
                label = 'Scout 3',
                spawnName = 'lssdscoutnew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscoutnew.webp",
                category= 'Grade',
                subCategory= 'Senior Lead Deputy'
            },
            {
                label = 'Fugitive',
                spawnName = 'sherifffug',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sherifffug.webp",
                category= 'Grade',
                subCategory= 'Senior Lead Deputy'
            },
            {
                label = 'Alamo',
                spawnName = 'lssdalamonew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffalamo.webp",
                category= 'Grade',
                subCategory= 'Senior Lead Deputy'
            },
            {
                label = 'Buffalo 2013',
                spawnName = 'lspdbuffalos',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalos.webp",
                category= 'Grade',
                subCategory= 'Senior Lead Deputy'
            },
            {
                label = 'Stanier',
                spawnName = 'lssdstanier1',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriff.webp",
                category= 'Grade',
                subCategory= 'Sergent'
            },
            {
                label = 'Scout 2',
                spawnName = 'lssdscout2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscout.webp",
                category= 'Grade',
                subCategory= 'Sergent'
            },
            {
                label = 'Scout 3',
                spawnName = 'lssdscoutnew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscoutnew.webp",
                category= 'Grade',
                subCategory= 'Sergent'
            },
            {
                label = 'Fugitive',
                spawnName = 'sherifffug',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sherifffug.webp",
                category= 'Grade',
                subCategory= 'Sergent'
            },
            {
                label = 'Alamo',
                spawnName = 'lssdalamonew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffalamo.webp",
                category= 'Grade',
                subCategory= 'Sergent'
            },
            {
                label = 'Buffalo 2013',
                spawnName = 'lspdbuffalos',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalos.webp",
                category= 'Grade',
                subCategory= 'Sergent'
            },
            {
                label = 'Buffalo STX Slick',
                spawnName = 'polbuffalog',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/polbuffalog.webp",
                category= 'Grade',
                subCategory= 'Sergent'
            },
            {
                label = 'Stalker',
                spawnName = 'sheriffstalker',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffstalker.webp",
                category= 'Grade',
                subCategory= 'Lieutenant'
            },
            {
                label = 'Stanier',
                spawnName = 'lssdstanier1',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriff.webp",
                category= 'Grade',
                subCategory= 'Lieutenant'
            },
            {
                label = 'Scout 2',
                spawnName = 'lssdscout2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscout.webp",
                category= 'Grade',
                subCategory= 'Lieutenant'
            },
            {
                label = 'Scout 3',
                spawnName = 'lssdscoutnew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscoutnew.webp",
                category= 'Grade',
                subCategory= 'Lieutenant'
            },
            {
                label = 'Fugitive',
                spawnName = 'sherifffug',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sherifffug.webp",
                category= 'Grade',
                subCategory= 'Lieutenant'
            },
            {
                label = 'Alamo',
                spawnName = 'lssdalamonew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffalamo.webp",
                category= 'Grade',
                subCategory= 'Lieutenant'
            },
            {
                label = 'Buffalo 2013',
                spawnName = 'lspdbuffalos',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalos.webp",
                category= 'Grade',
                subCategory= 'Lieutenant'
            },
            {
                label = 'Buffalo STX Slick',
                spawnName = 'polbuffalog',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/polbuffalog.webp",
                category= 'Grade',
                subCategory= 'Lieutenant'
            },
            {
                label = 'Stalker',
                spawnName = 'sheriffstalker',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffstalker.webp",
                category= 'Grade',
                subCategory= 'Lieutenant'
            },
            {
                label = 'Torrence',
                spawnName = 'sheriffintc',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffintc.webp",
                category= 'Grade',
                subCategory= 'Lieutenant'
            },
            {
                label = 'Stanier',
                spawnName = 'lssdstanier1',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriff.webp",
                category= 'Grade',
                subCategory= 'Executive Staff'
            },
            {
                label = 'Scout 2',
                spawnName = 'lssdscout2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscout.webp",
                category= 'Grade',
                subCategory= 'Executive Staff'
            },
            {
                label = 'Scout 3',
                spawnName = 'lssdscoutnew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscoutnew.webp",
                category= 'Grade',
                subCategory= 'Executive Staff'
            },
            {
                label = 'Fugitive',
                spawnName = 'sherifffug',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sherifffug.webp",
                category= 'Grade',
                subCategory= 'Executive Staff'
            },
            {
                label = 'Alamo',
                spawnName = 'lssdalamonew2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffalamo.webp",
                category= 'Grade',
                subCategory= 'Executive Staff'
            },
            {
                label = 'Buffalo 2013',
                spawnName = 'lspdbuffalos',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalos.webp",
                category= 'Grade',
                subCategory= 'Executive Staff'
            },
            {
                label = 'Buffalo STX Slick',
                spawnName = 'polbuffalog',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/polbuffalog.webp",
                category= 'Grade',
                subCategory= 'Executive Staff'
            },
            {
                label = 'Stalker',
                spawnName = 'sheriffstalker',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffstalker.webp",
                category= 'Grade',
                subCategory= 'Executive Staff'
            },
            {
                label = 'Torrence',
                spawnName = 'sheriffintc',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffintc.webp",
                category= 'Grade',
                subCategory= 'Executive Staff'
            },
            {
                label = 'Sheriff Ghost',
                spawnName = 'sheriffghost',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffghost.webp",
                category= 'Grade',
                subCategory= 'Executive Staff'
            },
            {
                label = 'Mule',
                spawnName = 'lssdmule',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/lssdmule.webp",
                category= 'Division',
                subCategory= 'Utility'
            },
            {
                label = 'Rumpo',
                spawnName = 'sheriffrumpo',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffrumpo.webp",
                category= 'Division',
                subCategory= 'Utility'
            },
            {
                label = 'Camion M.O.C',
                spawnName = 'mocpacker',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/mocpacker.webp",
                category= 'Division',
                subCategory= 'Utility'
            },
            {
                label = 'Van',
                spawnName = 'sheriffvanold',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffvanold.webp",
                category= 'Division',
                subCategory= 'Utility'
            },
            {
                label = 'Parking Pigeon',
                spawnName = 'pigeonp',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/pigeonp.webp",
                category= 'Division',
                subCategory= 'Utility'
            },
            {
                label = 'Anti Émeute',
                spawnName = 'riot2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/riot2.webp",
                category= 'Division',
                subCategory= 'Utility'
            },
            {
                label = 'Vélo',
                spawnName = 'lspdcycle',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/lspdcycle.webp",
                category= 'Division',
                subCategory= 'Utility'
            },
            {
                label = 'Riata Old',
                spawnName = 'sheriffriataold',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffriataold.webp",
                category= 'Division',
                subCategory= 'PUBLIC INFORMATION OFFICER'
            },
            {
                label = 'Stanier Old',
                spawnName = 'sheriffold2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffold2.webp",
                category= 'Division',
                subCategory= 'PUBLIC INFORMATION OFFICER'
            },
            {
                label = 'Alamo old',
                spawnName = 'sheriffalamoold',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffalamoold.webp",
                category= 'Division',
                subCategory= 'PUBLIC INFORMATION OFFICER'
            },
            {
                label = 'Trike',
                spawnName = 'sherifftrike',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sherifftrike.webp",
                category= 'Division',
                subCategory= 'PUBLIC INFORMATION OFFICER'
            },
            {
                label = 'Stanier Unmarked',
                spawnName = 'sheriffoss',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffoss.webp",
                category= 'Division',
                subCategory= 'BUREAU OF NARCOTICS'
            },
            {
                label = 'Scout Unmarked',
                spawnName = 'sheriffscout2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffscout2.webp",
                category= 'Division',
                subCategory= 'BUREAU OF NARCOTICS'
            },
            {
                label = 'Buffalo 2013 Unmarked',
                spawnName = 'lspdbuffaloum',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Concessionnaire/Voiture/buffalo.webp",
                category= 'Division',
                subCategory= 'BUREAU OF NARCOTICS'
            },
            {
                label = 'Stanier Slick',
                spawnName = 'lssdstanier2',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffslick.webp",
                category= 'Division',
                subCategory= 'BUREAU OF NARCOTICS'
            },
            {
                label = 'Minivan Unmarked',
                spawnName = 'gtfminivan',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Concessionnaire/Voiture/minivan.webp",
                category= 'Division',
                subCategory= 'BUREAU OF NARCOTICS'
            },
            {
                label = 'Oracle Unmarked',
                spawnName = 'lspdoraclemk2um',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Concessionnaire/Voiture/oracle2.webp",
                category= 'Division',
                subCategory= 'BUREAU OF NARCOTICS'
            },
            {
                label = 'Sultan Unmarked',
                spawnName = 'sultanumk',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Concessionnaire/Voiture/sultan.webp",
                category= 'Division',
                subCategory= 'BUREAU OF NARCOTICS'
            },
            {
                label = 'Torrence Unmarked',
                spawnName = 'lspdtorrenceum',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Concessionnaire/Voiture/torrence.webp",
                category= 'Division',
                subCategory= 'BUREAU OF NARCOTICS'
            },
            {
                label = 'Utility Rescue',
                spawnName = 'sheriffsar',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffsar.webp",
                category= 'Division',
                subCategory= 'NATURAL RESPONSIBILITY TASK'
            },
            {
                label = 'Sheriff OffRoad',
                spawnName = 'sheriffoffroad',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffoffroad.webp",
                category= 'Division',
                subCategory= 'NATURAL RESPONSIBILITY TASK'
            },
            {
                label = 'Remorque Bateau',
                spawnName = 'boattrailer',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/boattrailer.webp",
                category= 'Division',
                subCategory= 'NATURAL RESPONSIBILITY TASK'
            },
            {
                label = 'Dinghy LSSD',
                spawnName = 'poldinghy',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/poldinghy.webp",
                category= 'Division',
                subCategory= 'NATURAL RESPONSIBILITY TASK'
            },
            {
                label = 'Enduro Sheriff',
                spawnName = 'sheriffenduro',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffenduro.webp",
                category= 'Division',
                subCategory= 'NATURAL RESPONSIBILITY TASK'
            },
            {
                label = 'sheriffcont',
                spawnName = 'sheriffcont',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffcont.webp",
                category= 'Division',
                subCategory= 'NATURAL RESPONSIBILITY TASK'
            },
            {
                label = 'Verus',
                spawnName = 'lssdverus',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/lssdverus.webp",
                category= 'Division',
                subCategory= 'NATURAL RESPONSIBILITY TASK'
            },
            {
                label = 'Sheriff Bearcat',
                spawnName = 'LSPDCenturion',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdcenturion.webp",
                category= 'Division',
                subCategory= 'SPECIAL ENFORCEMENT BUREAU'
            },
            {
                label = 'Buffalo STX',
                spawnName = 'lspdbuffsx',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffsx.webp",
                category= 'Division',
                subCategory= 'SPECIAL ENFORCEMENT BUREAU'
            },
            {
                label = 'Sheriff Heavy',
                spawnName = 'sheriffheavy',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffheavy.webp",
                category= 'Division',
                subCategory= 'SPECIAL ENFORCEMENT BUREAU'
            },
            {
                label = 'Alamo K-9',
                spawnName = 'lssdalamonew1',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffalamo.webp",
                category= 'Division',
                subCategory= 'K-9'
            },
            {
                label = 'Stalker K9',
                spawnName = 'sheriffstalker',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffstalker.webp",
                category= 'Division',
                subCategory= 'K-9'
            },
            {
                label = 'Moto LSSD',
                spawnName = 'mbu2rb',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/mbu2rb.webp",
                category= 'Division',
                subCategory= 'TRAFFIC ENFORCEMENT BUREAU'
            },
            {
                label = 'Torrence',
                spawnName = 'sheriffintc',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/sheriffintc.webp",
                category= 'Division',
                subCategory= 'TRAFFIC ENFORCEMENT BUREAU'
            },
            {
                label = 'Buffalo STX',
                spawnName = 'polbuffalor',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/polbuffalor.webp",
                category= 'Division',
                subCategory= 'TRAFFIC ENFORCEMENT BUREAU'
            },
            {
                label = 'Van M.I.B',
                spawnName = 'sheriffvanold',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/polbuffalor.webp",
                category= 'Division',
                subCategory= 'M.I.B'
            },             
        },
    }
    
    
    function openLSSDGarageMenu()
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogue',
            data = listVeh
        }))
    end

        local listHeli = {
        headerImage = 'assets/headers/header_lssd.jpg',
        headerIcon = './assets/LSPD/logo_vehicule.png',
        headerIconName = 'HÉLICOPTÈRES',
        callbackName= 'Menu_LSSD_heli_callback',
        elements = {
            {
                label = 'Maverick',
                spawnName = 'lspdmav',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdmav.webp",
                category= 'Division',
                subCategory= 'AIR SUPPORT UNIT'
            },
            {
                label = 'SuperPuma ASU',
                spawnName = 'as332',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/as332.webp",
                category= 'Division',
                subCategory= 'AIR SUPPORT UNIT'
            },
            {
                label = 'SuperPuma SEB',
                spawnName = 'as332',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/as332seb.webp",
                category= 'Division',
                subCategory= 'SPECIAL ENFORCEMENT BUREAU'
            },
        }
    }

    function openGarageHeliLSSDMenu()
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogue',
            data = listHeli
        }))
    end

    local listBoat = {
        headerImage = 'assets/headers/header_lssd.jpg',
        headerIcon = './assets/LSPD/logo_vehicule.png',
        headerIconName = 'BATEAUX',
        callbackName= 'Menu_LSSD_boat_callback',
        elements = {
            {
                label = 'Predator',
                spawnName = 'polpreda',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/polpreda.webp",
                category= 'Division',
                subCategory= 'NRT'
            },
        }
    }

    function openGarageLSSDBoatMenu()
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


    RegisterNetEvent("core:lspdGetVehGarage")
    AddEventHandler("core:lspdGetVehGarage", function(data)
        allVehicleList = data
    end)

    RegisterNetEvent("core:lspdSpawnVehicle")
    AddEventHandler("core:lspdSpawnVehicle", function(data)
        currentVeh = data
        local veh = vehicle.create(data.name,
            vector4(-1061.701171875, -853.28356933594, 4.475266456604, 218.39852905273), {})
    end)

    local casierOpen = false
    function OpenlspdCasier()
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


    local function GetDatasProps()
        -- DataSendPropsLSSD.items.elements = {}

        local playerJobs = 'lspd-lssd'

        -- Cones
        for i = 1, 10 do
            table.insert(DataSendPropsLSSD.items[2].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Cones/"..i..".webp",
                category="Cones", 
                label = "#"..i
            })
        end


    -- Panneaux
        for i = 1, 8 do
            table.insert(DataSendPropsLSSD.items[3].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Panneaux/"..i..".webp",
                category="Panneaux",
                label = "#"..i
            })
        end

        -- Barrière
        for i = 1, 11 do
            table.insert(DataSendPropsLSSD.items[4].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Barrieres/"..i..".webp",
                category="Barrières",
                label = "#"..i
            })
        end

        -- Lumières
        for i = 1, 5 do
            table.insert(DataSendPropsLSSD.items[5].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Lumieres/"..i..".webp",
                category="Lumières",
                label = "#"..i
            })
        end

        -- Tables
        for i = 1, 2 do
            table.insert(DataSendPropsLSSD.items[6].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Tables/"..i..".webp",
                category="Tables",
                label = "#"..i
            })
        end

        -- Drogues
        for i = 1, 9 do
            table.insert(DataSendPropsLSSD.items[7].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Drogues/"..i..".webp",
                category="Drogues",
                label = "#"..i
            })
        end

        -- Divers
        for i = 1, 4 do
            table.insert(DataSendPropsLSSD.items[8].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Divers/"..i..".webp",
                category="Divers",
                label = "#"..i
            })
        end

        -- Cible Tir
        for i = 1, 2 do
            table.insert(DataSendPropsLSSD.items[9].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/CiblesTir/"..i..".webp",
                category="Cibles Tir",
                label = "#"..i
            })
        end

        -- Sacs
        for i = 1, 2 do
            table.insert(DataSendPropsLSSD.items[10].elements, {
                id = i,
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/"..playerJobs.."/Sacs/"..i..".webp",
                category="Sacs",
                label = "#"..i
            })
        end


        DataSendPropsLSSD.disableSubmit = true

        return true
    end



    RegisterNUICallback("focusOut", function()
        if PropsMenu.open then
            PropsMenu.open = false 
        end
    end)


    DataSendPropsLSSD = {
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
        headerImage = 'assets/headers/header_lssd.jpg',
        callbackName = 'MenuObjetsServicesPublicsLSSD',
        showTurnAroundButtons = false,
    }

    local firstart = false

    OpenPropsMenuLSSD = function()
        if firstart == false then
            firstart = true 
            local bool = GetDatasProps()
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
            data = DataSendPropsLSSD
        }))
    end


end

function UnloadLssdJob()
    zone.removeZone("coffre_lssd")
    zone.removeZone("lssd_vest")
    zone.removeZone("lssd_vest_2")
    zone.removeZone("lssd_vehicule")
    zone.removeZone("lssd_vehicule_delete")
    zone.removeZone("lssd_vehicule2")
    zone.removeZone("lssd_vehicule2_delete")
    zone.removeZone("society_lssd1")
    zone.removeZone("society_lssd2")
    zone.removeZone("stockage_lssd")
    zone.removeZone("spawn_lssd_heli")
    zone.removeZone("society_lssdHeli_delete")
    zone.removeZone("spawn_lssd_heli2")
    zone.removeZone("society_lssdHeli2_delete")
    zone.removeZone("spawn_lssd_boat")
    zone.removeZone("society_lssdBoat_delete")
    lssdDuty = false
end

    -- MENU PROPS

    PropsMenu = {
        cam = nil,
        open = false,
    }

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
        ['#5']     = "bkr_prop_weed_med_01a",
        ['#6']     = "bkr_prop_weed_smallbag_01a",
        ['#7']     = "ex_office_swag_drugbag2",
        ['#8']     = "imp_prop_impexp_boxcoke_01",
        ['#9']     = "imp_prop_impexp_coke_pile",
    }

    local divers_models = {
        ['#1']     = "gr_prop_gr_laptop_01c",
        ['#2']     = "prop_ballistic_shield",
        ['#3']     = "prop_gazebo_02",
        ['#4']     = "prop_lssdpio",
    }

    local sacs_models = {
        ['#1']     = "xm_prop_x17_bag_01c",
        ['#2']     = "xm_prop_x17_bag_med_01a",
    }

    local cibletir_models = {
        ['#1']     = "gr_prop_gr_target_05a",
        ['#2']     = "gr_prop_gr_target_05b",
    }


    local lssdPropsPlaced = {}

    local function SpawnPropsLSSD(obj, name)
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

                OpenPropsMenuLSSD()
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
        table.insert(lssdPropsPlaced, {
            nom = name,
            prop = objS.id
        })
    end


    RegisterNUICallback("MenuObjetsServicesPublicsLSSD", function(data, cb)
        -- if data == nil or data.category == nil then return end
        -- PropsMenu.choice = data.category

        SendNuiMessage(json.encode({
            type = 'closeWebview',
        }))

        if data.category == "Cones" then 
            print(data.label)
            
            SpawnPropsLSSD(cones_models[data.label], data.label)
        end
        
        if data.category == "Panneaux" then 
            print(data.label)
        
            SpawnPropsLSSD(panneaux_models[data.label], data.label)
        end

        if data.category == "Barrières" then 
            print(data.label)

            SpawnPropsLSSD(barriere_models[data.label], data.label)
        end

        if data.category == "Lumières" then 
            print(data.label)

            SpawnPropsLSSD(lumiere_models[data.label], data.label)
        end

        if data.category == "Tables" then 
            print(data.label)

            
            SpawnPropsLSSD(tables_models[data.label], data.label)
        end

        if data.category == "Drogues" then 
            print(data.label)

            
            SpawnPropsLSSD(drogues_models[data.label], data.label)
        end

        if data.category == "Divers" then 
            print(data.label)

            
            SpawnPropsLSSD(divers_models[data.label], data.label)
        end

        if data.category == "Cibles Tir" then 
            print(data.label)

            
            SpawnPropsLSSD(cibletir_models[data.label], data.label)
        end

        if data.category == "Sacs" then 
            print(data.label)

            
            SpawnPropsLSSD(sacs_models[data.label], data.label)
        end

    end)

RegisterNUICallback("Menu_LSSD_vehicule_callback", function (data, cb)
    local distancenord = GetDistanceBetweenCoords(-475.86270141602, 6031.6201171875, 30.340396881104, GetEntityCoords(PlayerPedId()))
    if distancenord < 50.0 then
        if vehicle.IsSpawnPointClear(vector3(-475.86270141602, 6031.6201171875, 30.340396881104), 5.0) then
            -- if DoesEntityExist(vehs) then
            --     TriggerEvent('persistent-vehicles/forget-vehicle', vehs)
            --     DeleteEntity(vehs)
            -- end
            vehs = vehicle.create(data.spawnName, vector4(-475.86270141602, 6031.6201171875, 30.340396881104, 224.73480224609), {})
                if data.spawnName == "lspdcenturion" then
                    SetVehicleLivery(vehs, 2)
                elseif data.spawnName == 'poldinghy' then
                    SetVehicleLivery(vehs, 1)
                elseif data.spawnName == 'polpreda' then
                    SetVehicleLivery(vehs, 1)
                elseif data.spawnName == "mbu2rb" then
                    SetVehicleExtra(vehs, 1, 0)
                    SetVehicleExtra(vehs, 2, 0)
                    SetVehicleExtra(vehs, 3, 0)
                    SetVehicleExtra(vehs, 4, 0)
                    SetVehicleExtra(vehs, 5, 0)
                    SetVehicleExtra(vehs, 6, 0)
                    SetVehicleExtra(vehs, 7, 0)
                    SetVehicleExtra(vehs, 8, 0)
                    SetVehicleExtra(vehs, 9, 0)
                    SetVehicleExtra(vehs, 10, 1)
                    SetVehicleExtra(vehs, 11, 0)
                    SetVehicleExtra(vehs, 12, 1)
                elseif data.spawnName == 'polbuffalor' then
                    SetVehicleLivery(vehs, 1)
                elseif data.spawnName == 'polbuffalog' then
                    SetVehicleLivery(vehs, 1)
                elseif data.spawnName == 'lspdbuffalos' then
                    SetVehicleLivery(vehs, 2)
                elseif data.spawnName == 'mocpacker' then
                    SetVehicleLivery(vehs, 2)
                elseif data.label == 'Van M.I.B' then
                    SetVehicleLivery(vehs, 3)
                elseif data.spawnName == 'pigeonp' then
                    SetVehicleLivery(vehs, 1)
                elseif data.spawnName == 'sheriffcont' then
                    SetVehicleWheelType(vehs, 4)
                    SetVehicleMod(vehs, 23, 3, false)
                elseif data.spawnName == 'lssdscout2' then
                    SetVehicleWheelType(vehs, 4)
                    SetVehicleMod(vehs, 23, 3, false)
                end
                SetVehicleMod(vehs, 11, 1, false)
                SetVehicleMod(vehs, 12, 1, false)
                SetVehicleMod(vehs, 13, 1, false)
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
            if vehicle.IsSpawnPointClear(vector3(2832.306640625, 4770.091796875, 45.993293762207), 3.0) then
                vehs = vehicle.create(data.spawnName, vector4(2832.306640625, 4770.091796875, 45.993293762207, 13.906717300415), {})
                if data.spawnName == "lspdcenturion" then
                    SetVehicleLivery(vehs, 2)
                elseif data.spawnName == 'poldinghy' then
                    SetVehicleLivery(vehs, 1)
                elseif data.spawnName == 'lspdbuffalos' then
                    SetVehicleLivery(vehs, 2)
                elseif data.spawnName == 'polpreda' then
                    SetVehicleLivery(vehs, 1)
                elseif data.spawnName == "mbu2rb" then
                    SetVehicleExtra(vehs, 1, 0)
                    SetVehicleExtra(vehs, 2, 0)
                    SetVehicleExtra(vehs, 3, 0)
                    SetVehicleExtra(vehs, 4, 0)
                    SetVehicleExtra(vehs, 5, 0)
                    SetVehicleExtra(vehs, 6, 0)
                    SetVehicleExtra(vehs, 7, 0)
                    SetVehicleExtra(vehs, 8, 0)
                    SetVehicleExtra(vehs, 9, 0)
                    SetVehicleExtra(vehs, 10, 1)
                    SetVehicleExtra(vehs, 11, 0)
                    SetVehicleExtra(vehs, 12, 1)
                elseif data.spawnName == 'polbuffalor' then
                    SetVehicleLivery(vehs, 1)
                elseif data.spawnName == 'polbuffalog' then
                    SetVehicleLivery(vehs, 1)
                elseif data.spawnName == 'mocpacker' then
                    SetVehicleLivery(vehs, 2)
                elseif data.label == 'Van M.I.B' then
                    SetVehicleLivery(vehs, 3)
                elseif data.spawnName == 'pigeonp' then
                    SetVehicleLivery(vehs, 1)
                elseif data.spawnName == 'sheriffcont' then
                    SetVehicleWheelType(vehs, 4)
                    SetVehicleMod(vehs, 23, 3, false)
                elseif data.spawnName == 'lssdscout2' then
                    SetVehicleWheelType(vehs, 4)
                    SetVehicleMod(vehs, 23, 3, false)
                end
                SetVehicleMod(vehs, 11, 1, false)
                SetVehicleMod(vehs, 12, 1, false)
                SetVehicleMod(vehs, 13, 1, false)
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

RegisterNUICallback("Menu_LSSD_heli_callback", function (data, cb)
    local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -475.26971435547, 5988.333984375, 30.336494445801)
    if distance < 50.0 then
        if vehicle.IsSpawnPointClear(vector3(-475.26971435547, 5988.333984375, 30.336494445801), 3.0) then
            vehs = vehicle.create(data.spawnName, vector4(-475.26971435547, 5988.333984375, 30.336494445801, 318.09353637695), {})
            -- SetVehicleLivery(vehs, 0)
            if data.spawnName == 'lspdmav' then
                SetVehicleLivery(vehs, 4)
            elseif data.label == 'SuperPuma ASU' then
                SetVehicleLivery(vehs, 0)
            elseif data.label == 'SuperPuma SEB' then
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
        if vehicle.IsSpawnPointClear(vector3(2751.9211425781, 4850.3271484375, 46.371780395508), 3.0) then
            vehs = vehicle.create(data.spawnName, vector4(2751.9211425781, 4850.3271484375, 46.371780395508, 186.9973449707), {})
            -- SetVehicleLivery(vehs, 0)
            if data.spawnName == 'lspdmav' then
                SetVehicleLivery(vehs, 4)
            elseif data.label == 'SuperPuma ASU' then
                SetVehicleLivery(vehs, 0)
            elseif data.label == 'SuperPuma SEB' then
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

RegisterNUICallback("Menu_LSSD_boat_callback", function (data, cb)
    if vehicle.IsSpawnPointClear(vector3(1453.8256835938, 3767.2709960938, 30.746427536011), 3.0) then
        vehs = vehicle.create(data.spawnName, vector4(1454.3397216797, 3772.1853027344, 28.974069595337, 293.28298950195), {})
        if data.spawnName == 'polpreda' then
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

RegisterNUICallback("armoryTakeLSSD", function(data, cb)
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
