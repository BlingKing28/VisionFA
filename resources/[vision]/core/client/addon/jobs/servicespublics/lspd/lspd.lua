local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local policePropsPlaced = {}
local created = false

local pos = {vector4(-1061.6607666016, -854.06854248047, 4.4745573997498, 216.77090454102),
             vector4(-1058.2822265625, -851.34600830078, 4.4748911857605, 215.81349182129),
             vector4(-1054.9798583984, -849.21118164063, 4.4743595123291, 216.47830200195),
             vector4(-1052.1146240234, -847.17211914063, 4.4742436408997, 219.34120178223),
             vector4(-1047.6822509766, -846.54187011719, 4.4742650985718, 215.94868469238),
             vector4(-1039.9312744141, -855.85925292969, 4.484121799469, 61.242832183838),
             vector4(-1042.2041015625, -858.88641357422, 4.4951553344727, 60.308723449707),
             vector4(-1045.2904052734, -861.26391601563, 4.5224432945251, 59.472263336182),
             vector4(-1048.1364746094, -865.01666259766, 4.6711006164551, 235.95852661133),
             vector4(-1051.6546630859, -867.56799316406, 4.7890930175781, 58.965156555176),
             vector4(-1069.6568603516, -878.66918945313, 4.5044069290161, 29.255399703979),
             vector4(-1072.6293945313, -880.328125, 4.4300155639648, 27.023773193359),
             vector4(-1076.3111572266, -882.57110595703, 4.3359618186951, 31.309888839722),
             vector4(-1079.6446533203, -884.19110107422, 4.2593250274658, 30.147357940674)}

Citizen.CreateThread(function()
    local ped = nil
    local ped2 = nil
    local ped3 = nil
    if not created then
        ped = entity:CreatePedLocal("s_m_y_cop_01", vector3(-1091.1064453125, -826.34027099609, 25.82693672180),
            68.676681518555)
        ped2 = entity:CreatePedLocal("s_m_y_cop_01", vector3(-1097.5017089844, -839.79248046875, 18.001207351685),
            125.86557006836)
        ped3 = entity:CreatePedLocal("s_m_y_cop_01", vector3(-1066.8187255859, -848.08740234375, 4.0423698425293),
            218.41899108887)

        created = true

    end
    SetEntityInvincible(ped.id, true)
    ped:setFreeze(true)
    TaskStartScenarioInPlace(ped.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
    SetEntityAsMissionEntity(ped.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped.id, true)
    SetEntityInvincible(ped2.id, true)
    ped2:setFreeze(true)
    TaskStartScenarioInPlace(ped2.id, "WORLD_HUMAN_CLIPBOARD", -1, true)
    SetEntityAsMissionEntity(ped2.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped2.id, true)

    ped3:setFreeze(true)
    SetEntityInvincible(ped3.id, true)
    SetEntityAsMissionEntity(ped3.id, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped3.id, true)
end)

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

policeDuty = false

function LoadLspdJob()

    local coffrePos = {vector3(-1096.9400634766, -830.31158447266, 26.827005386353),
                       vector3(-1087.1840820313, -812.73260498047, 5.4792823791504),
    -- vector3(-1121.4798583984, -833.59747314453, 19.316497802734), outside
                       vector3(-1095.697265625, -824.0, 26.826816558838),
                       vector3(-1098.9569091797, -827.09417724609, 26.826910018921)}

    local vehicleOut = nil
    local currentVeh = nil

    local items = {
        headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Banners/LSPD.webp',
        headerIcon = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Banners/icon.webp',
        headerIconName = 'CATALOGUE',
        callbackName = 'armoryTakeLSPD',
        showTurnAroundButtons = false,
        multipleSelection = true,
        elements = {{
            price = 0,
            id = 1,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/shield.webp",
            name = "shield",
            label = "Bouclier anti-émeute"
        }, {
            price = 0,
            id = 2,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Fumigene.webp",
            name = "weapon_smokelspd",
            label = "Fumigene"
        }, {
            price = 0,
            id = 3,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Fusee_detresse.webp",
            name = "weapon_flare",
            label = "Fusée de détresse"
        }, {
            price = 0,
            id = 4,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/Gaz_bz.webp",
            name = "weapon_bzgas",
            label = "GAZ BZ"
        }, {
            price = 0,
            id = 5,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lspdgiletj.webp",
            name = "lspdgiletj",
            label = "Gilet Jaune"
        }, {
            price = 0,
            id = 6,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lspdkevle1.webp",
            name = "lspdkevle1",
            label = "Kevlar Class A 1"
        }, {
            price = 0,
            id = 7,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lspdkevle2.webp",
            name = "lspdkevle2",
            label = "Kevlar Class A 2"
        }, {
            price = 0,
            id = 8,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lspdkevle3.webp",
            name = "lspdkevle3",
            label = "Kevlar Class A 3"
        }, {
            price = 0,
            id = 9,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lspdriot.webp",
            name = "lspdriot",
            label = "Protection Anti Emeute"
        }, {
            price = 0,
            id = 10,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lspdkevm1.webp",
            name = "lspdkevm1",
            label = "Kevlar Class B"
        }, {
            price = 0,
            id = 11,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lspdkevlo1.webp",
            name = "lspdkevlo1",
            label = "Kevlar Class C 1"
        }, {
            price = 0,
            id = 12,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lspdkevlo2.webp",
            name = "lspdkevlo2",
            label = "Kevlar Class C 2"
        }, {
            price = 0,
            id = 13,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lspdkevlo3.webp",
            name = "lspdkevlo3",
            label = "Kevlar Class C 3"
        }, {
            price = 0,
            id = 14,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lspdswat.webp",
            name = "lspdswat",
            label = "Kevlar SWAT"
        }, {
            price = 0,
            id = 15,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lspdkevpc.webp",
            name = "lspdkevpc",
            label = "Gilet Pare Couteau"
        }, {
            price = 0,
            id = 16,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lspdgnd.webp",
            name = "lspdgnd",
            label = "Gilet GND"
        }, {
            price = 0,
            id = 16,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/lspdgnd2.webp",
            name = "lspdgnd2",
            label = "Kevlar GND"
        }, {
            price = 0,
            id = 18,
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Armurerie/Items/radio.webp",
            name = "radio",
            label = "Radio"
        }}
    }

    function OpenPoliceITEMMenu()
        FreezeEntityPosition(PlayerPedId(), true)
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogueAchat',
            data = items
        }));

        RegisterNUICallback("focusOut", function(data, cb)
            TriggerScreenblurFadeOut(0.5)
            openRadarProperly()
            RenderScriptCams(false, false, 0, 1, 0)
            DestroyCam(cam, false)
            FreezeEntityPosition(PlayerPedId(), false)
        end)
    end

    function LSPDAnnounce()
        if policeDuty then
            local annonce = KeyboardImput("Entrez le contenu de l'annonce")
            if annonce ~= "" and type(annonce) == "string" then
                TriggerServerEvent("core:makeAnnounceLspd", token, annonce)
            else
                -- ShowNotification("~r~Veuillez entrer un texte valide")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Veuillez entrer un texte valide"
                })

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
    local listHeli = {
        headerImage = './assets/LSPD/header.png',
        headerIcon = './assets/LSPD/logo_vehicule.png',
        headerIconName = 'VEHICULE',
        callbackName = 'Menu_LSPD_heli_callback',
        elements = {{
            label = 'Maverick',
            spawnName = 'lspdmav',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdmav.webp",
            category = 'Division',
            subCategory = 'Air Support Division'
        }, {
            label = 'Valkyrie',
            spawnName = 'lspdvalkyrie',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdvalkyrie.webp",
            category = 'Division',
            subCategory = 'Metropolitan Division'
        }}
    }

    function openGarageHeliLSPDMenu()
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogue',
            data = listHeli
        }))
    end

    local listBoat = {
        headerImage = './assets/LSPD/header.png',
        headerIcon = './assets/LSPD/logo_vehicule.png',
        headerIconName = 'VEHICULE',
        callbackName = 'Menu_LSPD_boat_callback',
        elements = {{
            label = 'Jet-ski',
            spawnName = 'lspdseashark',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/emsseashark.webp",
            category = 'Division',
            subCategory = 'Los Santos Port Police'
        }, {
            label = 'Dinghy',
            spawnName = 'poldinghy',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/poldinghy.webp",
            category = 'Division',
            subCategory = 'Los Santos Port Police'
        }, {
            label = 'Predator',
            spawnName = 'polpreda',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/polpreda.webp",
            category = 'Division',
            subCategory = 'Los Santos Port Police'
        }}
    }

    function openGarageLSPDBoatMenu()
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogue',
            data = listBoat
        }))
    end

    zone.addZone("police_item", vector3(-1106.4849853516, -825.69818115234, 13.206984519958),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir l'armurerie ", function()
            OpenPoliceITEMMenu()
        end, false, -- Avoir un marker ou non
        -1, -- Id / type du marker
        0.6, -- La taille
        {0, 0, 0}, -- RGB
        0, -- Alpha
        2.5 -- Interact dist
    )

    zone.addZone("police_garage", vector3(-1069.8516845703, -855.00463867188, 4.8674259185791),
        "Appuyer sur ~INPUT_CONTEXT~ pour rentrer dans le garage", function()
            if IsPedInAnyVehicle(p:ped(), false) then
                local veh = GetVehiclePedIsIn(p:ped(), false)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                DeleteEntity(veh)
            end
        end, false)
    zone.addZone("society_lspd_custom", vector3(-1069.373046875, -878.74835205078, 4.851348400116),
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
    zone.addZone("society_lspdHeli_delete", vector3(-1097.2193603516, -823.01092529297, 39.95372390747),
        "Appuyer sur ~INPUT_CONTEXT~ pour ranger le véhicule", function()
            if IsPedInAnyVehicle(p:ped(), false) then
                local veh = GetVehiclePedIsIn(p:ped(), false)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                DeleteEntity(veh)

            end
        end, true, 36, 0.5, {255, 0, 0}, 255)
    zone.addZone("society_lspdBoat_delete", vector3(-797.44512939453, -1517.0225830078, 1.0),
        "Appuyer sur ~INPUT_CONTEXT~ pour ranger le véhicule", function()
            if IsPedInAnyVehicle(p:ped(), false) then
                local veh = GetVehiclePedIsIn(p:ped(), false)
                removeKeys(GetVehicleNumberPlateText(veh), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(veh))
                TriggerEvent('persistent-vehicles/forget-vehicle', veh)
                DeleteEntity(veh)

            end
        end, true, 35, 0.6, {255, 0, 0}, 170)
    zone.addZone("spawn_lspd_heli", vector3(-1104.4073486328, -831.92193603516, 36.774224853516),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage", function()
            openGarageHeliLSPDMenu()
        end, true, 25, -- Id / type du marker
        0.6, -- La taille
        {51, 204, 255}, -- RGB
        170 --
    )
    zone.addZone("spawn_lspd_boat", vector3(-806.29077148438, -1496.9188232422, 0.6),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage", function()
            openGarageLSPDBoatMenu()
        end, true, 25, -- Id / type du marker
        0.6, -- La taille
        {51, 204, 255}, -- RGB
        170 --
    )
    zone.addZone("police_garage_vehicle", vector3(-1066.849609375, -848.0146484375, 4.0426015853882),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir la liste des véhicules", function()
            openGarageMenu()
            forceHideRadar()
        end, false, 25, -- Id / type du marker
        0.6, -- La taille
        {51, 204, 255}, -- RGB
        170 -- Alpha
    )

    zone.addZone("society_police", vector3(-1113.2972412109, -833.466796875, 33.361099243164),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les actions d'entreprise", function()
            OpenSocietyMenu() -- TODO: fini le menu society
        end, false, 25, -- Id / type du marker
        0.6, -- La taille
        {51, 204, 255}, -- RGB
        170 -- Alpha
    )

    zone.addZone("stockage_police", vector3(-1088.0415039063, -809.822265625, 4.4792771339417),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le stockage police", function()
            OpenInventorySocietyMenu() -- TODO: fini le menu society
        end, false, 25, -- Id / type du marker
        0.6, -- La taille
        {51, 204, 255}, -- RGB
        170 -- Alpha
    )

    zone.addZone("vestiaire_police", vector3(-1091.6655273438, -826.08685302734, 25.826871871948),
        "Appuyer sur ~INPUT_CONTEXT~ pour prendre une tenue", function()
            LoadVestiaireLSPD() -- TODO: fini le menu society
        end, true, 25, -- Id / type du marker
        0.6, -- La taille
        {51, 204, 255}, -- RGB
        170 -- Alpha
    )

    for k, v in pairs(coffrePos) do
        zone.addZone("coffre_police" .. k, v, "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les casiers",
            function()
                OpenlspdCasier() -- TODO: fini le menu society
            end, false, 25, -- Id / type du marker
            0.6, -- La taille
            {51, 204, 255}, -- RGB
            170 -- Alpha
        )
    end

    -- DEV
    local tenueH = {
        ['tshirt_1'] = 217,
        ['tshirt_2'] = 0,
        ['torso_1'] = 484,
        ['torso_2'] = 0,
        ['arms'] = 11,
        ['arms_2'] = 0,
        ['pants_1'] = 170,
        ['pants_2'] = 2,
        ['shoes_1'] = 130,
        ['shoes_2'] = 0,
        ['bags_1'] = 140,
        ['bags_2'] = 0,
        ['chain_1'] = 172,
        ['chain_2'] = 0,
        ['bproof_1'] = 0,
        ['bproof_2'] = 0,
        ['helmet_1'] = -1,
        ['helmet_2'] = 0
    }
    local tenueF = {
        ['tshirt_1'] = 255,
        ['tshirt_2'] = 0,
        ['torso_1'] = 520,
        ['torso_2'] = 0,
        ['arms'] = 9,
        ['arms_2'] = 0,
        ['pants_1'] = 175,
        ['pants_2'] = 0,
        ['shoes_1'] = 134,
        ['shoes_2'] = 0,
        ['bags_1'] = 134,
        ['bags_2'] = 0,
        ['chain_1'] = 141,
        ['chain_2'] = 0,
        ['bproof_1'] = 0,
        ['bproof_2'] = 0,
        ['helmet_1'] = -1,
        ['helmet_2'] = 0
    }

    local openRadial = false

    local open = false
    local lspdmenu_objects = RageUI.CreateMenu("", "LSPD", 0.0, 0.0, "vision", "menu_title_police")
    local lspdmenu_traffic = RageUI.CreateMenu("", "LSPD", 0.0, 0.0, "vision", "menu_title_police")
    local lspdmenu_traffic_add = RageUI.CreateSubMenu(lspdmenu_traffic, "", "LSPD", 0.0, 0.0, "vision",
        "menu_title_police")
    local lspdmenu_traffic_view = RageUI.CreateSubMenu(lspdmenu_traffic, "", "LSPD", 0.0, 0.0, "vision",
        "menu_title_police")
    local lspdmenu_objects_delete = RageUI.CreateSubMenu(lspdmenu_objects, "", "LSPD", 0.0, 0.0, "vision",
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
        if policeDuty then
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
                            RageUI.Button("Ajouter une zone", nil, {
                                RightLabel = ">"
                            }, true, {
                                onSelected = function()
                                    zonePos = p:pos()
                                end
                            }, lspdmenu_traffic_add)
                            -- for the second button to view my zones, it opens a menu where i can see all my zones and delete them
                            RageUI.Button("Voir les zones", nil, {
                                RightLabel = ">"
                            }, true, {
                                onSelected = function()
                                    traficList = TriggerServerCallback("lspd:traffic:get")
                                end
                            }, lspdmenu_traffic_view)
                        end)
                        RageUI.IsVisible(lspdmenu_traffic_add, function()
                            -- for the speed and radius button, prompt a keyboard to enter the value
                            RageUI.Button("Vitesse", nil, {
                                RightLabel = speed .. " km/h"
                            }, true, {
                                onSelected = function()
                                    speed = tonumber(KeyboardImput("Vitesse")) + .0
                                    if speed == nil then
                                        speed = 0.0
                                    end
                                end
                            })
                            RageUI.Button("Rayon", nil, {
                                RightLabel = radius .. " m"
                            }, true, {
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
                            RageUI.Button("Nom de la zone", nil, {
                                RightLabel = zoneName
                            }, true, {
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
                        RageUI.IsVisible(lspdmenu_traffic_view, function()
                            for k, v in pairs(traficList) do
                                RageUI.Button(v.zoneId .. " | " .. v.zoneName, nil, {
                                    RightLabel = "~r~ Supprimer"
                                }, true, {
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
                                        DrawMarker(1, v.zonePos + vector3(0.0, 0.0, -1000.0), 0.0, 0.0, 0.0, 0.0, 0.0,
                                            .0, distance + .0, distance + .0, 10000.0, 20, 192, 255, 70, 0, 0, 2, 0, 0,
                                            0, 0)
                                    end
                                })
                            end
                        end)
                        if show then
                            -- draw circle around player with the radius of the zone
                            local distance = radius + .0
                            DrawMarker(1, p:pos() + vector3(0.0, 0.0, -1000.0), 0.0, 0.0, 0.0, 0.0, 0.0, .0,
                                distance + .0, distance + .0, 10000.0, 20, 192, 255, 70, 0, 0, 2, 0, 0, 0, 0)
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

    function policeActionDuty()
        openRadial = false
        closeUI()
        if policeDuty then
            TriggerServerEvent('core:DutyOff', 'lspd')
            --[[             ShowAdvancedNotification("Centrale", "~b~Dispatch", "Vous avez quitté votre service", "CHAR_CALL911",
                "CHAR_CALL911") ]]

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s quitté ~c votre service"
            })

            policeDuty = false
            Wait(5000)
        else
            TriggerServerEvent('core:DutyOn', 'lspd')
            --[[             ShowAdvancedNotification("Centrale", "~b~Dispatch", "Vous avez pris votre service", "CHAR_CALL911",
                "CHAR_CALL911") ]]

            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s pris ~c votre service"
            })

            policeDuty = true
            Wait(5000)
        end
    end

    function makeRenfortCall()
        if policeDuty then
            TriggerServerEvent('core:makeCall', "lspd", p:pos(), false, "appel de renfort")
            -- ExecuteCommand("me fait un appel de renfort")
            -- p:PlayAnim('amb@code_human_police_investigate@idle_a', 'idle_b', 51)
            openRadial = false
            closeUI()
            -- Modules.UI.RealWait(10000)
            -- ClearPedTasks(p:ped())
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

    function ConvocationLSPD()
        if policeDuty then
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

    function FactureLSPD()
        if policeDuty then
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

    function DepositionLSPD()
        if policeDuty then
            openRadial = false
            closeUI()
            TriggerEvent("nuiPapier:client:startCreation", 4)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function CreateAdvert()
        if policeDuty then
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

    function OpenRadialPoliceMenu()
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
                        data = {
                            elements = {{
                                name = "CONVOCATION",
                                icon = "assets/svg/radial/top_paper.svg",
                                action = "ConvocationLSPD"
                            }, {
                                name = "FACTURE",
                                icon = "assets/svg/radial/billet.svg",
                                action = "FactureLSPD"
                            }, {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenMainRadialLSPD"
                            }, {
                                name = "DEPOSITION",
                                icon = "assets/svg/radial/paper.svg",
                                action = "DepositionLSPD"
                            }},
                            title = "PAPIERS"
                        }
                    }));
                end

                function OpenSubRadialActions()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = {
                            elements = {{
                                name = "ANNONCE",
                                icon = "assets/svg/radial/megaphone.svg",
                                action = "CreateAdvert"
                            }, {
                                name = "CIRCULATION",
                                icon = "assets/svg/radial/road.svg",
                                action = "openTraficMenu"
                            }, {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenMainRadialLSPD"
                            }, {
                                name = "OBJETS",
                                icon = "assets/svg/radial/object.svg",
                                action = "OpenPropsMenuLSPD"
                            }},
                            title = "ACTIONS"
                        }
                    }));
                end

                function OpenMainRadialLSPD()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = {
                            elements = {{
                                name = "APPEL DE RENFORT",
                                icon = "assets/svg/radial/police_logo.svg",
                                action = "makeRenfortCall"
                            }, {
                                name = "PAPIERS",
                                icon = "assets/svg/radial/paper.svg",
                                action = "OpenSubRadialPapiers"
                            }, {
                                name = "PRISE DE SERVICE",
                                icon = "assets/svg/radial/checkmark.svg",
                                action = "policeActionDuty"
                            }, {
                                name = "ACTIONS",
                                icon = "assets/svg/radial/police.svg",
                                action = "OpenSubRadialActions"
                            }},
                            title = "POLICE"
                        }
                    }));
                end

                OpenMainRadialLSPD()
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

    RegisterJobMenu(OpenRadialPoliceMenu)

    local oldSkin = {}
    local open = false
    local outifitmenu = RageUI.CreateMenu("", "LSPD", 0.0, 0.0, "vision", "menu_title_police")
    local outfitmenu_list = RageUI.CreateSubMenu(outifitmenu, "", "LSPD", 0.0, 0.0, "vision", "menu_title_police")
    outifitmenu.Closed = function()
        local playerSkin = p:skin()
        ApplySkin(oldSkin)
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
            oldSkin = p:skin()
            Citizen.CreateThread(function()
                while open do
                    RageUI.IsVisible(outifitmenu, function()
                        for k, v in pairs(police.outfit) do
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
                                                    TriggerSecurGiveEvent("core:addItemToInventory", token, "outfit", 1, {
                                                        renamed = k,
                                                        data = v.male
                                                    })
                                                end
                                            else
                                                if v.female then
                                                    TriggerSecurGiveEvent("core:addItemToInventory", token, "outfit", 1, {
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

    local garagePos = vector4(1295.3653564453, 220.2564239502, -49.057468414307, 1.7115516662598)
    local plyInGarage = false

    local defaultVehExpo = {{
        pos = vector3(1310.1032714844, 228.28462219238, -50.005670166016),
        heading = 88.874877929688,
        model = "police2"
    }, {
        pos = vector3(1310.1687011719, 231.40347290039, -50.005670166016),
        heading = 270.60833740234,
        model = "police"
    }, {
        pos = vector3(1309.8950195313, 246.94641113281, -50.005670166016),
        heading = 88.889739990234,
        model = "police3"
    }, {
        pos = vector3(1294.9595947266, 239.01225280762, -50.005670166016),
        heading = 270.05737304688,
        model = "police"
    }, {
        pos = vector3(1280.6026611328, 244.06103515625, -50.005670166016),
        heading = 270.41748046875,
        model = "fbi"
    }, {
        pos = vector3(1280.5715332031, 251.97434997559, -50.005670166016),
        heading = 90.602905273438,
        model = "riot"
    }}

    local vehExpo = nil

    local function LoadCarsinGarage()
        for k, v in pairs(defaultVehExpo) do
            vehExpo = entity:CreateVehicleLocal(v.model, v.pos, v.heading)
            vehExpo:setFreeze(true)
            SetVehicleDoorsLocked(vehExpo:getEntityId(), true)
            SetVehicleUndriveable(vehExpo:getEntityId(), true)
            SetVehicleDirtLevel(vehExpo:getEntityId(), 0.0)
        end
    end

    function enterInGarage()
        RequestIpl("vw_casino_garage")
        while not IsIplActive("vw_casino_garage") do
            Wait(1)
        end
        plyInGarage = true
        SetEntityCoords(p:ped(), garagePos.x, garagePos.y, garagePos.z)
        SetEntityHeading(p:ped(), garagePos.w)
        Wait(100)

        zone.addZone("police_garage_exit", vector3(1295.2905273438, 217.6827545166, -49.055416107178),
            "Appuyer sur ~INPUT_CONTEXT~ pour sortir du garage", function()
                leaveGarage()
            end, false)
        LoadCarsinGarage()
    end

    function leaveGarage()
        vehExpo:delete()
        Wait(100)
        SetEntityCoords(p:ped(), -1069.8516845703, -855.00463867188, 4.8674259185791)
        SetEntityHeading(p:ped(), 216.99613952637)
        plyInGarage = false
        zone.removeZone("police_garage_vehicle")
        zone.removeZone("police_garage_exit")
    end

    local open = false
    local lspdgarage_main = RageUI.CreateMenu("", "LSPD", 0.0, 0.0, "vision", "menu_title_police")
    local lspdgarage_vehicle =
        RageUI.CreateSubMenu(lspdgarage_main, "", "LSPD", 0.0, 0.0, "vision", "menu_title_police")
    lspdgarage_main.Closed = function()
        open = false
    end

    local allVehicleList = {}
    local selected_vehicle = nil

    local vehs = nil
    ---OpenVeh

    local listVeh = {
        headerImage = './assets/headers/header_lspd.jpg',
        headerIcon = './assets/icons/voiture-icon.png',
        headerIconName = 'VEHICULE',
        callbackName = 'Menu_LSPD_vehicule_callback',
        elements = {{
            label = 'Stanier',
            spawnName = 'lspdstanier',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdstanier.webp",
            category = 'Grades',
            subCategory = 'ROOKIE'
        }, --- OFFICIER I
        {
            label = 'Stanier',
            spawnName = 'lspdstanier',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdstanier.webp",
            category = 'Grades',
            subCategory = 'OFFICIER I'
        }, {
            label = "Scout '16",
            spawnName = 'lspdscout3',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscout3.webp",
            category = 'Grades',
            subCategory = 'OFFICIER I'
        }, --- OFFICIER 2
        {
            label = 'Stanier',
            spawnName = 'lspdstanier',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdstanier.webp",
            category = 'Grades',
            subCategory = 'OFFICIER II'
        }, {
            label = "Scout '16",
            spawnName = 'lspdscout3',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscout3.webp",
            category = 'Grades',
            subCategory = 'OFFICIER II'
        }, {
            label = 'Torrence',
            spawnName = 'lspdtorrence',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdtorrence.webp",
            category = 'Grades',
            subCategory = 'OFFICIER II'
        }, --- OFFICIER III
        {
            label = 'Stanier',
            spawnName = 'lspdstanier',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdstanier.webp",
            category = 'Grades',
            subCategory = 'OFFICIER III'
        }, {
            label = "Scout '16",
            spawnName = 'lspdscout3',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscout3.webp",
            category = 'Grades',
            subCategory = 'OFFICIER III'
        }, {
            label = "Scout '20",
            spawnName = 'lspdscoutnew1',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscout.webp",
            category = 'Grades',
            subCategory = 'OFFICIER III'
        }, {
            label = 'Torrence',
            spawnName = 'lspdtorrence',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdtorrence.webp",
            category = 'Grades',
            subCategory = 'OFFICIER III'
        }, {
            label = 'Fugitive',
            spawnName = 'lspdfugitive',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdfugitive.webp",
            category = 'Grades',
            subCategory = 'OFFICIER III'
        }, --- SLO
        {
            label = 'Stanier',
            spawnName = 'lspdstanier',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdstanier.webp",
            category = 'Grades',
            subCategory = 'SENIOR LEAD OFFICER'
        }, {
            label = "Scout '16",
            spawnName = 'lspdscout3',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscout3.webp",
            category = 'Grades',
            subCategory = 'SENIOR LEAD OFFICER'
        }, {
            label = "Scout '20",
            spawnName = 'lspdscoutnew1',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscout.webp",
            category = 'Grades',
            subCategory = 'SENIOR LEAD OFFICER'
        }, {
            label = 'Torrence',
            spawnName = 'lspdtorrence',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdtorrence.webp",
            category = 'Grades',
            subCategory = 'SENIOR LEAD OFFICER'
        }, {
            label = 'Fugitive',
            spawnName = 'lspdfugitive',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdfugitive.webp",
            category = 'Grades',
            subCategory = 'SENIOR LEAD OFFICER'
        }, {
            label = 'Buffalo',
            spawnName = 'lspdbuffalo',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalo.webp",
            category = 'Grades',
            subCategory = 'SENIOR LEAD OFFICER'
        }, --- SERGENT I
        {
            label = 'Stanier',
            spawnName = 'lspdstanier',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdstanier.webp",
            category = 'Grades',
            subCategory = 'SERGENT I'
        }, {
            label = "Scout '16",
            spawnName = 'lspdscout3',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscout3.webp",
            category = 'Grades',
            subCategory = 'SERGENT I'
        }, {
            label = "Scout '20",
            spawnName = 'lspdscoutnew1',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscout.webp",
            category = 'Grades',
            subCategory = 'SERGENT I'
        }, {
            label = 'Torrence',
            spawnName = 'lspdtorrence',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdtorrence.webp",
            category = 'Grades',
            subCategory = 'SERGENT I'
        }, {
            label = 'Fugitive',
            spawnName = 'lspdfugitive',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdfugitive.webp",
            category = 'Grades',
            subCategory = 'SERGENT I'
        }, {
            label = 'Buffalo',
            spawnName = 'lspdbuffalo',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalo.webp",
            category = 'Grades',
            subCategory = 'SERGENT I'
        }, {
            label = 'Buffalo S',
            spawnName = 'lspdbuffalos',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalos.webp",
            category = 'Grades',
            subCategory = 'SERGENT I'
        }, --- SERGENT II
        {
            label = 'Stanier',
            spawnName = 'lspdstanier',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdstanier.webp",
            category = 'Grades',
            subCategory = 'SERGENT II'
        }, {
            label = "Scout '16",
            spawnName = 'lspdscout3',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscout3.webp",
            category = 'Grades',
            subCategory = 'SERGENT II'
        }, {
            label = "Scout '20",
            spawnName = 'lspdscoutnew1',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscout.webp",
            category = 'Grades',
            subCategory = 'SERGENT II'
        }, {
            label = 'Torrence',
            spawnName = 'lspdtorrence',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdtorrence.webp",
            category = 'Grades',
            subCategory = 'SERGENT II'
        }, {
            label = 'Fugitive',
            spawnName = 'lspdfugitive',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdfugitive.webp",
            category = 'Grades',
            subCategory = 'SERGENT II'
        }, {
            label = 'Buffalo',
            spawnName = 'lspdbuffalo',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalo.webp",
            category = 'Grades',
            subCategory = 'SERGENT II'
        }, {
            label = 'Buffalo S',
            spawnName = 'lspdbuffalos',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalos.webp",
            category = 'Grades',
            subCategory = 'SERGENT II'
        }, --- LIEUTENANT
        {
            label = 'Stanier',
            spawnName = 'lspdstanier',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdstanier.webp",
            category = 'Grades',
            subCategory = 'LIEUTENANT'
        }, {
            label = "Scout '16",
            spawnName = 'lspdscout3',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscout3.webp",
            category = 'Grades',
            subCategory = 'LIEUTENANT'
        }, {
            label = "Scout '20",
            spawnName = 'lspdscoutnew1',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscout.webp",
            category = 'Grades',
            subCategory = 'LIEUTENANT'
        }, {
            label = 'Torrence',
            spawnName = 'lspdtorrence',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdtorrence.webp",
            category = 'Grades',
            subCategory = 'LIEUTENANT'
        }, {
            label = 'Fugitive',
            spawnName = 'lspdfugitive',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdfugitive.webp",
            category = 'Grades',
            subCategory = 'LIEUTENANT'
        }, {
            label = 'Buffalo',
            spawnName = 'lspdbuffalo',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalo.webp",
            category = 'Grades',
            subCategory = 'LIEUTENANT'
        }, {
            label = 'Buffalo S',
            spawnName = 'lspdbuffalos',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalos.webp",
            category = 'Grades',
            subCategory = 'LIEUTENANT'
        }, {
            label = 'Buffalo STX Slick',
            spawnName = 'polbuffalog',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/polbuffalog.webp",
            category = 'Grades',
            subCategory = 'LIEUTENANT'
        }, --- CAPTAIN
        {
            label = 'Stanier',
            spawnName = 'lspdstanier',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdstanier.webp",
            category = 'Grades',
            subCategory = 'CAPTAIN'
        }, {
            label = "Scout '16",
            spawnName = 'lspdscout3',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscout3.webp",
            category = 'Grades',
            subCategory = 'CAPTAIN'
        }, {
            label = "Scout '20",
            spawnName = 'lspdscoutnew1',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscout.webp",
            category = 'Grades',
            subCategory = 'CAPTAIN'
        }, {
            label = 'Torrence',
            spawnName = 'lspdtorrence',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdtorrence.webp",
            category = 'Grades',
            subCategory = 'CAPTAIN'
        }, {
            label = 'Fugitive',
            spawnName = 'lspdfugitive',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdfugitive.webp",
            category = 'Grades',
            subCategory = 'CAPTAIN'
        }, {
            label = 'Buffalo',
            spawnName = 'lspdbuffalo',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalo.webp",
            category = 'Grades',
            subCategory = 'CAPTAIN'
        }, {
            label = 'Buffalo S',
            spawnName = 'lspdbuffalos',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalos.webp",
            category = 'Grades',
            subCategory = 'CAPTAIN'
        }, {
            label = 'Alamo',
            spawnName = 'lspdalamo',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdalamo.webp",
            category = 'Grades',
            subCategory = 'CAPTAIN'
        }, {
            label = 'Buffalo STX Slick',
            spawnName = 'polbuffalog',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/polbuffalog.webp",
            category = 'Grades',
            subCategory = 'CAPTAIN'
        }, -- MES VEHICULES
        --[[ {
                label = 'Stanier',
                spawnName = 'lspdstanier',
                image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdstanier.webp",
                category= 'Mes véhicules',
                subCategory= 'ROOKIE'
            }, ]] -- DETECTIVE DIVISION
        {
            label = 'Buffalo S',
            spawnName = 'lspdbuffalosum',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalosum.webp",
            category = 'Division',
            subCategory = 'DETECTIVE DIVISION'
        }, {
            label = 'Buffalo',
            spawnName = 'lspdbuffaloum',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalosum.webp",
            category = 'Division',
            subCategory = 'DETECTIVE DIVISION'
        }, {
            label = 'Stanier',
            spawnName = 'lspdstanierum',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdstanierum.webp",
            category = 'Division',
            subCategory = 'DETECTIVE DIVISION'
        }, {
            label = "Scout '14",
            spawnName = 'lspdscoutum',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscoutum.webp",
            category = 'Division',
            subCategory = 'DETECTIVE DIVISION'
        }, {
            label = "Scout '16 UMK",
            spawnName = 'lspdumkscout16',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdumkscout16.webp",
            category = 'Division',
            subCategory = 'DETECTIVE DIVISION'

        }, {
            label = 'Torrence',
            spawnName = 'lspdtorrenceum',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdtorrenceum.webp",
            category = 'Division',
            subCategory = 'DETECTIVE DIVISION'
        }, {
            label = 'Sultan',
            spawnName = 'sultanumk',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Concessionnaire/Voiture/sultan.webp",
            category = 'Division',
            subCategory = 'DETECTIVE DIVISION'
        }, {
            label = 'Oracle Mk2',
            spawnName = 'lspdoraclemk2um',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Concessionnaire/Voiture/oracle2.webp",
            category = 'Division',
            subCategory = 'DETECTIVE DIVISION'
        }, {
            label = 'Minivan UMK',
            spawnName = 'gtfminivan',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Concessionnaire/Voiture/minivan.webp",
            category = 'Division',
            subCategory = 'DETECTIVE DIVISION'
        }, -- GND
        {
            label = 'Buffalo S',
            spawnName = 'lspdbuffalosum',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalosum.webp",
            category = 'Division',
            subCategory = 'GANG AND NARCOTIC DIVISION'
        }, {
            label = 'Buffalo',
            spawnName = 'lspdbuffaloum',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffalosum.webp",
            category = 'Division',
            subCategory = 'GANG AND NARCOTIC DIVISION'
        }, {
            label = 'Stanier',
            spawnName = 'lspdstanierum',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdstanierum.webp",
            category = 'Division',
            subCategory = 'GANG AND NARCOTIC DIVISION'
        }, {
            label = "Scout '14",
            spawnName = 'lspdscoutum',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscoutum.webp",
            category = 'Division',
            subCategory = 'GANG AND NARCOTIC DIVISION'
        }, {
            label = "Scout '16 UMK",
            spawnName = 'lspdumkscout16',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdumkscout16.webp",
            category = 'Division',
            subCategory = 'GANG AND NARCOTIC DIVISION'

        }, {
            label = 'Torrence',
            spawnName = 'lspdtorrenceum',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdtorrenceum.webp",
            category = 'Division',
            subCategory = 'GANG AND NARCOTIC DIVISION'
        }, {
            label = 'Sultan',
            spawnName = 'sultanumk',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Concessionnaire/Voiture/sultan.webp",
            category = 'Division',
            subCategory = 'GANG AND NARCOTIC DIVISION'
        }, {
            label = 'Oracle Mk2',
            spawnName = 'lspdoraclemk2um',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Concessionnaire/Voiture/oracle2.webp",
            category = 'Division',
            subCategory = 'GANG AND NARCOTIC DIVISION'
        }, {
            label = 'Minivan',
            spawnName = 'gtfminivan',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Concessionnaire/Voiture/minivan.webp",
            category = 'Division',
            subCategory = 'GANG AND NARCOTIC DIVISION'
        }, {
            label = 'Stanier slick',
            spawnName = 'lspdstanierslick',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdstanierslick.webp",
            category = 'Division',
            subCategory = 'GANG AND NARCOTIC DIVISION'
        }, {
            label = 'Torrence slick',
            spawnName = 'lspdtorrenceslick',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdtorrenceslick.webp",
            category = 'Division',
            subCategory = 'GANG AND NARCOTIC DIVISION'
        }, {
            label = "Scout '16 Slick",
            spawnName = 'lspdumkscout16',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdumkscout16slick.webp",
            category = 'Division',
            subCategory = 'GANG AND NARCOTIC DIVISION'
        }, {
            label = "Scout '20 Slick",
            spawnName = 'lspdscoutnew3',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscoutnew3.webp",
            category = 'Division',
            subCategory = 'GANG AND NARCOTIC DIVISION'
        }, -- METROPOLITAN DIVISION
        {
            label = 'Stanier Slick',
            spawnName = 'lspdstanierslick',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdstanierslick.webp",
            category = 'Division',
            subCategory = 'METROPOLITAN DIVISION'

        }, {
            label = 'Scout',
            spawnName = 'lspdscoutum',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscoutum.webp",
            category = 'Division',
            subCategory = 'METROPOLITAN DIVISION'

        }, {
            label = 'Buffalo STX',
            spawnName = 'lspdbuffsx',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbuffsx.webp",
            category = 'Division',
            subCategory = 'METROPOLITAN DIVISION'

        }, {
            label = 'Granger',
            spawnName = 'swatgrangerold',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/swatgrangerold.webp",
            category = 'Division',
            subCategory = 'METROPOLITAN DIVISION'

        }, {
            label = 'Centurion',
            spawnName = 'lspdcenturion',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdcenturion.webp",
            category = 'Division',
            subCategory = 'METROPOLITAN DIVISION'

        }, {
            label = 'Camion M.O.C SWAT',
            spawnName = 'mocpacker',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/mocpacker.webp",
            category = 'Division',
            subCategory = 'METROPOLITAN DIVISION'

        }, -- K-9
        {
            label = 'Scout',
            spawnName = 'lspdscoutk9',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscoutk9.webp",
            category = 'Division',
            subCategory = 'K-9 PLATOON'

        }, {
            label = 'Scout 2',
            spawnName = 'lspdscoutk92',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdscoutk92.webp",
            category = 'Division',
            subCategory = 'K-9 PLATOON'

        }, {
            label = 'Sadlerk',
            spawnName = 'lspdsadlerk9',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdsadlerk9.webp",
            category = 'Division',
            subCategory = 'K-9 PLATOON'

        }, -- Traffic Division
        {
            label = 'Buffalo STX',
            spawnName = 'polbuffalor',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/polbuffalor.webp",
            category = 'Division',
            subCategory = 'TRAFFIC DIVISION'
        }, {
            label = 'Thrust LSPD',
            spawnName = 'lspdthrust',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdthrust.webp",
            category = 'Division',
            subCategory = 'TRAFFIC DIVISION'
        }, {
            label = 'Wintergreen LSPD',
            spawnName = 'lspdwintergreen',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdwintergreen.webp",
            category = 'Division',
            subCategory = 'TRAFFIC DIVISION'
        }, {
            label = 'Moto LSPD',
            spawnName = 'mbu2rb',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSSD/mbu2rb.webp",
            category = 'Division',
            subCategory = 'TRAFFIC DIVISION'
        }, -- MEDIA RELATION DIVISION
        {
            label = 'Raiden',
            spawnName = 'lspdraiden',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdraiden.webp",
            category = 'Division',
            subCategory = 'MEDIA RELATION DIVISION'

        }, -- Divers
        {
            label = 'Speedo',
            spawnName = 'lspdspeedo',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdspeedo.webp",
            category = 'Division',
            subCategory = 'DIVERS'
        }, {
            label = 'Bus',
            spawnName = 'lspdbus',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdbus.webp",
            category = 'Division',
            subCategory = 'DIVERS'
        }, {
            label = 'Camion M.O.C',
            spawnName = 'mocpacker',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/mocpacker.webp",
            category = 'Division',
            subCategory = 'DIVERS'
        }, {
            label = 'Everon',
            spawnName = 'lspdeveron',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/lspdeveron.webp",
            category = 'Division',
            subCategory = 'DIVERS'
        }, {
            label = 'Riot',
            spawnName = 'riot2',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/riot2.webp",
            category = 'Division',
            subCategory = 'DIVERS'
        }, {
            label = 'Parking Pigeon',
            spawnName = 'pigeonp',
            image = "https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/LSPD/pigeonp.webp",
            category = 'Division',
            subCategory = 'DIVERS'
        }}
    }

    function openGarageMenu()
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogue',
            data = listVeh
        }))
    end

    RegisterNUICallback("focusOut", function(data, cb)
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
                        count = 199
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

    -- MENU PROPS 

    local function GetDatasProps()
        -- DataSendPropsLSPD.items.elements = {}

        local playerJobs = 'lspd-lssd'

        -- Cones
        for i = 1, 10 do
            table.insert(DataSendPropsLSPD.items[2].elements, {
                id = i,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/" .. playerJobs .. "/Cones/" .. i .. ".webp",
                category = "Cones",
                label = "#" .. i
            })
        end

        -- Panneaux
        for i = 1, 8 do
            table.insert(DataSendPropsLSPD.items[3].elements, {
                id = i,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/" .. playerJobs .. "/Panneaux/" .. i .. ".webp",
                category = "Panneaux",
                label = "#" .. i
            })
        end

        -- Barrière
        for i = 1, 11 do
            table.insert(DataSendPropsLSPD.items[4].elements, {
                id = i,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/" .. playerJobs .. "/Barrieres/" .. i .. ".webp",
                category = "Barrières",
                label = "#" .. i
            })
        end

        -- Lumières
        for i = 1, 5 do
            table.insert(DataSendPropsLSPD.items[5].elements, {
                id = i,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/" .. playerJobs .. "/Lumieres/" .. i .. ".webp",
                category = "Lumières",
                label = "#" .. i
            })
        end

        -- Tables
        for i = 1, 2 do
            table.insert(DataSendPropsLSPD.items[6].elements, {
                id = i,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/" .. playerJobs .. "/Tables/" .. i .. ".webp",
                category = "Tables",
                label = "#" .. i
            })
        end

        -- Drogues
        for i = 1, 9 do
            table.insert(DataSendPropsLSPD.items[7].elements, {
                id = i,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/" .. playerJobs .. "/Drogues/" .. i .. ".webp",
                category = "Drogues",
                label = "#" .. i
            })
        end

        -- Divers
        for i = 1, 4 do
            table.insert(DataSendPropsLSPD.items[8].elements, {
                id = i,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/" .. playerJobs .. "/Divers/" .. i .. ".webp",
                category = "Divers",
                label = "#" .. i
            })
        end

        -- Cible Tir
        for i = 1, 2 do
            table.insert(DataSendPropsLSPD.items[9].elements, {
                id = i,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/" .. playerJobs .. "/CiblesTir/" .. i .. ".webp",
                category = "Cibles Tir",
                label = "#" .. i
            })
        end

        -- Sacs
        for i = 1, 2 do
            table.insert(DataSendPropsLSPD.items[10].elements, {
                id = i,
                image = "https://assets-vision-fa.cdn.purplemaze.net/assets/PropsMenu/" .. playerJobs .. "/Sacs/" .. i .. ".webp",
                category = "Sacs",
                label = "#" .. i
            })
        end

        DataSendPropsLSPD.disableSubmit = true

        return true
    end

    PropsMenu = {
        cam = nil,
        open = false
    }

    RegisterNUICallback("focusOut", function()
        if PropsMenu.open then
            PropsMenu.open = false
        end
    end)

    DataSendPropsLSPD = {
        items = {{
            name = 'main',
            type = 'buttons',
            elements = {{
                name = 'Cones',
                width = 'full',
                image = 'assets/PropsMenu/cones.svg',
                hoverStyle = ' stroke-black'
            }, {
                name = 'Panneaux',
                width = 'full',
                image = 'assets/PropsMenu/roadsign.svg',
                hoverStyle = ' stroke-black'
            }, {
                name = 'Barrières',
                width = 'full',
                image = 'assets/PropsMenu/barriere.svg',
                hoverStyle = ' stroke-black'
            }, {
                name = 'Lumières',
                width = 'full',
                image = 'assets/PropsMenu/light.svg',
                hoverStyle = ' stroke-black'
            }, {
                name = 'Tables',
                width = 'full',
                image = 'assets/PropsMenu/table.svg',
                hoverStyle = ' stroke-black'
            }, {
                name = 'Drogues',
                width = 'full',
                image = 'assets/PropsMenu/drogues.svg',
                hoverStyle = ' stroke-black'
            }, {
                name = 'Divers',
                width = 'full',
                image = 'assets/PropsMenu/divers.svg',
                hoverStyle = ' stroke-black'
            }, {
                name = 'Cibles Tir',
                width = 'full',
                image = 'assets/PropsMenu/ciblestir.svg',
                hoverStyle = ' stroke-black'
            }, {
                name = 'Sacs',
                width = 'full',
                image = 'assets/PropsMenu/sacs.svg',
                hoverStyle = ' stroke-black'
            }}
        }, {
            name = 'Cones',
            type = 'elements',
            elements = {}
        }, {
            name = 'Panneaux',
            type = 'elements',
            elements = {}
        }, {
            name = 'Barrières',
            type = 'elements',
            elements = {}
        }, {
            name = 'Lumières',
            type = 'elements',
            elements = {}
        }, {
            name = 'Tables',
            type = 'elements',
            elements = {}
        }, {
            name = 'Drogues',
            type = 'elements',
            elements = {}
        }, {
            name = 'Divers',
            type = 'elements',
            elements = {}
        }, {
            name = 'Cibles Tir',
            type = 'elements',
            elements = {}
        }, {
            name = 'Sacs',
            type = 'elements',
            elements = {}
        }},

        -- headerIcon = 'assets/icons/market-cart.png',
        -- headerIconName = 'Cones',
        headerImage = 'assets/headers/header_lspd.jpg',
        callbackName = 'MenuObjetsServicesPublicsLSPD',
        showTurnAroundButtons = false
    }

    local firstart = false

    OpenPropsMenuLSPD = function()
        if firstart == false then
            firstart = true
            local bool = GetDatasProps()
            while not bool do
                Wait(1)
            end
        end
        SendNuiMessage(json.encode({
            type = 'closeWebview'
        }))
        Wait(50)
        PropsMenu.open = true
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuObjetsServicesPublics',
            data = DataSendPropsLSPD
        }))
    end

end

function UnloadLspdJob()
    zone.removeZone("coffre_police")
    zone.removeZone("lspdOutfit")
    zone.removeZone("police_garage")
    zone.removeZone("society_police")
    zone.removeZone("stockage_police")
    zone.removeZone("police_item")
    zone.removeZone("police_garage_vehicle")
    zone.removeZone("spawn_lspd_heli")
    zone.removeZone("society_lspdHeli_delete")
    zone.removeZone("spawn_lspd_boat")
    zone.removeZone("society_lspdBoat_delete")
    policeDuty = false
end

local function showBadge(text)

end

RegisterNetEvent("core:badge")
AddEventHandler("core:badge", function(data)

    if data == "lspd" then

    end

end)

RegisterNUICallback("Menu_LSPD_vehicule_callback", function(data, cb)
    for key, value in pairs(pos) do
        if vehicle.IsSpawnPointClear(vector3(value.x, value.y, value.z), 3.0) then
            vehs = vehicle.create(data.spawnName, vector4(value), {})
            SetVehicleMod(vehs, 11, 1, false)
            SetVehicleMod(vehs, 12, 1, false)
            SetVehicleMod(vehs, 13, 1, false)
            if data.spawnName == "lspdcenturion" then
                SetVehicleLivery(vehs, 0)
            elseif data.spawnName == 'polbuffalor' then
                SetVehicleLivery(vehs, 0)
            elseif data.spawnName == 'polbuffalog' then
                SetVehicleLivery(vehs, 0)
            elseif data.spawnName == 'lspdbuffalos' then
                SetVehicleLivery(vehs, 0)
            elseif data.spawnName == 'lspdeveron' then
                SetVehicleLivery(vehs, 0)
            elseif data.spawnName == "lspdtorrence2" then
                SetVehicleExtra(vehs, 4, 0)
                SetVehicleExtra(vehs, 5, 1)
                SetVehicleExtra(vehs, 6, 0)
                SetVehicleExtra(vehs, 8, 0)
                SetVehicleExtra(vehs, 9, 0)
            elseif data.label == 'Camion M.O.C SWAT' then
                SetVehicleLivery(vehs, 1)
            elseif data.label == 'Camion M.O.C' then
                SetVehicleLivery(vehs, 0)
            elseif data.label == "Scout '16 UMK" then
                SetVehicleLivery(vehs, 1)
            elseif data.label == "Scout '16 Slick" then
                SetVehicleLivery(vehs, 0)
            elseif data.spawnName == "mbu2rb" then
                SetVehicleLivery(vehs, 1)
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
            elseif data.spawnName == "pigeonp" then
                SetVehicleLivery(vehs, 0)
            end
            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
            SendNuiMessage(json.encode({
                type = 'closeWebview'
            }))
            return
        end
    end
end)

RegisterNUICallback("armoryTakeLSPD", function(data, cb)
    for k, v in pairs(data) do
        TriggerSecurGiveEvent("core:addItemToInventory", token, v.name, 1, {})
        exports['vNotif']:createNotification({
            type = 'DOLLAR',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous venez de récupérer ~s un(e) " .. v.label
        })
    end
    SendNuiMessage(json.encode({
        type = 'closeWebview'
    }))
end)

RegisterNUICallback("Menu_LSPD_heli_callback", function(data, cb)
    if vehicle.IsSpawnPointClear(vector3(-1097.2193603516, -823.01092529297, 39.95372390747), 3.0) then
        vehs = vehicle.create(data.spawnName,
            vector4(-1097.2193603516, -823.01092529297, 39.953723907471, 200.25018310547), {})
        -- SetVehicleLivery(vehs, 0)
        if data.spawnName == 'lspdmav' then
            SetVehicleLivery(vehs, 1)
        elseif data.spawnName == 'lspdvalkyrie' then
            SetVehicleLivery(vehs, 0)
        end
        local plate = vehicle.getProps(vehs).plate
        local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
        local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
        createKeys(plate, model)
        SendNuiMessage(json.encode({
            type = 'closeWebview'
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

RegisterNUICallback("Menu_LSPD_boat_callback", function(data, cb)
    if vehicle.IsSpawnPointClear(vector3(-801.99151611328, -1500.0753173828, -0.47385582327843), 3.0) then
        vehs = vehicle.create(data.spawnName,
            vector4(-801.99151611328, -1500.0753173828, -0.47385582327843, 108.33866882324), {})
        if data.spawnName == 'lspdseashark' then
            SetVehicleLivery(vehs, 0)
        elseif data.spawnName == 'poldinghy' then
            SetVehicleLivery(vehs, 3)
        elseif data.spawnName == 'polpreda' then
            SetVehicleLivery(vehs, 0)
        end
        local plate = vehicle.getProps(vehs).plate
        local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
        local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
        createKeys(plate, model)
        SendNuiMessage(json.encode({
            type = 'closeWebview'
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

local function SpawnPropsLSPD(obj, name)
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

            OpenPropsMenuLSPD()
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

local cones_models = {
    ['#1'] = "prop_air_conelight",
    ['#2'] = "prop_barrier_wat_03b",
    ['#3'] = "prop_mp_cone_03",
    ['#4'] = "prop_mp_cone_04",
    ['#5'] = "prop_roadcone02a",
    ['#6'] = "prop_roadcone02b",
    ['#7'] = "prop_roadpole_01a",
    ['#8'] = "prop_roadpole_01b",
    ['#9'] = "prop_trafficdiv_01",
    ['#10'] = "prop_trafficdiv_02"
}

local panneaux_models = {
    ['#1'] = "prop_consign_01b",
    ['#2'] = "prop_consign_02a",
    ['#3'] = "prop_sign_road_01a",
    ['#4'] = "prop_sign_road_03a",
    ['#5'] = "prop_sign_road_06a",
    ['#6'] = "prop_sign_road_06f",
    ['#7'] = "prop_sign_road_06q",
    ['#8'] = "prop_sign_road_06r"
}

local barriere_models = {
    ['#1'] = "prop_barier_conc_05c",
    ['#2'] = "prop_barrier_work01a",
    ['#3'] = "prop_barrier_work01b",
    ['#4'] = "prop_barrier_work02a",
    ['#5'] = "prop_barrier_work06b",
    ['#6'] = "prop_fncsec_04a",
    ['#7'] = "prop_mp_arrow_barrier_01",
    ['#8'] = "prop_mp_barrier_02b",
    ['#9'] = "prop_plas_barier_01a",
    ['#10'] = "prop_barrier_work05",
    ['#11'] = "prop_barrier_work06a"
}

local lumiere_models = {
    ['#1'] = "prop_generator_03b",
    ['#2'] = "prop_worklight_01a",
    ['#3'] = "prop_worklight_03b",
    ['#4'] = "prop_worklight_04a",
    ['#5'] = "prop_worklight_04b"
}

local tables_models = {
    ['#1'] = "bkr_prop_weed_table_01b",
    ['#2'] = "prop_ven_market_table1"
}

local drogues_models = {
    ['#1'] = "bkr_prop_bkr_cashpile_01",
    ['#2'] = "bkr_prop_meth_openbag_02",
    ['#3'] = "bkr_prop_meth_smallbag_01a",
    ['#4'] = "bkr_prop_moneypack_03a",
    ['#5'] = "bkr_prop_weed_med_01a",
    ['#6'] = "bkr_prop_weed_smallbag_01a",
    ['#7'] = "ex_office_swag_drugbag2",
    ['#8'] = "imp_prop_impexp_boxcoke_01",
    ['#9'] = "imp_prop_impexp_coke_pile"
}

local divers_models = {
    ['#1'] = "gr_prop_gr_laptop_01c",
    ['#2'] = "prop_ballistic_shield",
    ['#3'] = "prop_gazebo_02",
    ['#4'] = "prop_lspdpio"
}

local sacs_models = {
    ['#1'] = "xm_prop_x17_bag_01c",
    ['#2'] = "xm_prop_x17_bag_med_01a"
}

local cibletir_models = {
    ['#1'] = "gr_prop_gr_target_05a",
    ['#2'] = "gr_prop_gr_target_05b"
}

RegisterNUICallback("MenuObjetsServicesPublicsLSPD", function(data, cb)
    -- if data == nil or data.category == nil then return end
    -- PropsMenu.choice = data.category

    SendNuiMessage(json.encode({
        type = 'closeWebview'
    }))

    if data.category == "Cones" then
        print(data.label)

        SpawnPropsLSPD(cones_models[data.label], data.label)
    end

    if data.category == "Panneaux" then
        print(data.label)

        SpawnPropsLSPD(panneaux_models[data.label], data.label)
    end

    if data.category == "Barrières" then
        print(data.label)

        SpawnPropsLSPD(barriere_models[data.label], data.label)
    end

    if data.category == "Lumières" then
        print(data.label)

        SpawnPropsLSPD(lumiere_models[data.label], data.label)
    end

    if data.category == "Tables" then
        print(data.label)

        SpawnPropsLSPD(tables_models[data.label], data.label)
    end

    if data.category == "Drogues" then
        print(data.label)

        SpawnPropsLSPD(drogues_models[data.label], data.label)
    end

    if data.category == "Divers" then
        print(data.label)

        SpawnPropsLSPD(divers_models[data.label], data.label)
    end

    if data.category == "Cibles Tir" then
        print(data.label)

        SpawnPropsLSPD(cibletir_models[data.label], data.label)
    end

    if data.category == "Sacs" then
        print(data.label)

        SpawnPropsLSPD(sacs_models[data.label], data.label)
    end

end)

RegisterNetEvent("lspd:traffic:addclient", function(zone)
    AddRoadNodeSpeedZone(zone.zonePos, zone.zoneRadius, zone.zoneSpeed, true)
end)

RegisterNetEvent("lspd:traffic:removeclient", function(zone)
    RemoveRoadNodeSpeedZone(zone)
end)