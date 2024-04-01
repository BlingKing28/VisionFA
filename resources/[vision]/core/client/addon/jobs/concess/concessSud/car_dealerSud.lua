local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local colors_list = {
    { id = 1, name = "Noir" },
    { id = 5, name = "Gris" },
    { id = 74, name = "Blanc" },
    --{ id = 158, name = "dorée" },
}

local color = 1
local inService = false
function LoadcardealerSudJob()
    local inService = false
    local openRadial = false

    zone.addZone("concess_gestionsociety", -- Nom
        vector3(144.57060241699, -1100.5737304688, 28.19504737854), -- Position
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir", -- Text afficher
        function() -- Action qui seras fait
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
        end, false, -- Avoir un marker ou non
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    zone.addZone("concess_gestionsocietysss", -- Nom
        vector3(131.42639160156, -1088.7276611328, 28.195070266724), -- Position
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir", -- Text afficher
        function() -- Action qui seras fait
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
        end, true, -- Avoir un marker ou non
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )
    zone.addZone("concess_gestion", -- Nom
        vector3(157.70098876953, -1098.7393798828, 28.21148109436), -- Position
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir", -- Text afficher
        function() -- Action qui seras fait
            if inService then
                openGestionMenu()
            else
                -- ShowNotification("~r~Vous n'êtes pas en service")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous n'êtes ~s pas en service"
                })

            end
        end, false, -- Avoir un marker ou non
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    zone.addZone("concess_delete_test",
        vector3(166.21952819824, -1081.3702392578, 29.195537567139),
        "Appuyer sur ~INPUT_CONTEXT~ pour supprimer le véhicule",
        function()
            if inService then
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if vehicle ~= 0 then
                    TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
                    removeKeys(GetVehicleNumberPlateText(vehicle), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))))
                    TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(vehicle))
                    if GetVehicleNumberPlateText(vehicle) == tryPlate then
                        TriggerServerEvent('core:unsetTryCar', "sud")
                    end
                    DeleteEntity(vehicle)
                else
                    -- ShowNotification("~r~Vous n'êtes pas dans un véhicule")

                    -- New notif
                    exports['vNotif']:createNotification({
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Vous n'êtes pas dans un véhicule"
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
        end, true,
        36, 0.5, { 255, 0, 0 }, 255
    )

    local function closestPlayer()
        local players = GetActivePlayers()
        print('player', json.encode(players))
        local closestDistance = -1
        local closestPlayer = -1
        local ply = PlayerPedId()
        print('ply', ply)
        local plyCoords = GetEntityCoords(ply, 0)
    
        for index, value in ipairs(players) do
            local target = GetPlayerPed(value)
            if (target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"],
                    plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
                if (closestDistance == -1 or closestDistance > distance) then
                    closestPlayer = value
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance
    end

    local open = false
    local selected_category
    local selected_vehicle
    local stockmenu_main =
    RageUI.CreateMenu("", "Gérer le stock", 0.0, 0.0, "root_cause", "shopui_title_premiumdeluxe")
    local stockmenu_category = RageUI.CreateSubMenu(stockmenu_main, "", "Gérer le stock", 0.0, 0.0, "root_cause",
        "shopui_title_premiumdeluxe")
    local stockmenu_buy = RageUI.CreateSubMenu(stockmenu_category, "", "Gérer le stock", 0.0, 0.0, "root_cause",
        "shopui_title_premiumdeluxe")
    stockmenu_main.Closed = function()
        open = false
    end

    local concessStock = {}

    function openStockMenu()
        if open then
            open = false
            RageUI.Visible(stockmenu_main, false)
        else
            open = true
            openRadial = false
            closeUI()
            RageUI.Visible(stockmenu_main, true)

            Citizen.CreateThread(function()
                while open do
                    RageUI.IsVisible(stockmenu_main, function()
                        for k, v in pairs(concessSud.vehicle) do
                            print(k, v)
                            RageUI.Button(k, nil, {}, true, {
                                onSelected = function()
                                    selected_category = v
                                end
                            }, stockmenu_category)
                        end
                    end)
                    RageUI.IsVisible(stockmenu_category, function()
                        for i = 1, #selected_category, 1 do
                            RageUI.Button(GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(selected_category[i].name)))
                                , nil,
                                {
                                    RightLabel = "~g~" .. selected_category[i].price .. "$"
                                }, true, {
                                    onSelected = function()
                                        selected_vehicle = selected_category[i]
                                    end
                                }, stockmenu_buy)
                        end
                    end)
                    RageUI.IsVisible(stockmenu_buy, function()
                        RageUI.Separator("Vehicule: " ..
                            GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(selected_vehicle.name))))
                        RageUI.Separator("Prix: " .. selected_vehicle.price)
                        RageUI.Button("Acheter", nil, {
                            RightLabel = ">"
                        }, true, {
                            onSelected = function()
                                TriggerServerEvent('core:cardealerBuyVeh', token, selected_vehicle,
                                    selected_vehicle.price, "cardealerSud")

                                --[[ Ancienne notification
                                --ShowNotification("~g~Vous avez acheté " ..
                                    GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(selected_vehicle.name))))
                                --]]

                                -- New notif
                                exports['vNotif']:createNotification({
                                    type = 'DOLLAR',
                                    -- duration = 5, -- In seconds, default:  4
                                    content = "Vous avez acheté ~s " .. GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(selected_vehicle.name)))
                                })

                                RageUI.GoBack()
                            end
                        })
                        RageUI.Button("Faire essayer",
                            "Voulez-vous faire essayer le véhicule à la personne la plus proche ?", {}, true, {
                            onSelected = function()
                                local closestPlayer, closestDistance = closestPlayer()
                                -- if closestPlayer ~= nil and closestDistance < 3.0 then
                                print(GetPlayerServerId(closestPlayer), closestDistance)
                                if not TriggerServerCallback("core:isTryCar", 'sud') then
                                    TriggerServerEvent('core:cardealerTryVeh', token, GetPlayerServerId(closestPlayer),
                                        selected_vehicle.name, "cardealerSud")
                                else
                                    exports['vNotif']:createNotification({
                                        type = 'ROUGE',
                                        -- duration = 5, -- In seconds, default:  4
                                        content = "un vehicule est déja ~s en essai"
                                    })
                                end
                                -- else
                                -- ShowAdvancedNotification("Vision", "Concessionnaire", "Aucun joueur dans la zone", "CHAR_VISION", "VISION")
                                -- end
                            end
                        })
                    end)
                    Wait(1)
                end
            end)
        end
    end

    RegisterNetEvent("core:cardealerSudGetStock")
    AddEventHandler("core:cardealerSudGetStock", function(data)
        concessStock = data
    end)

    local open = false
    local gestionmenu_main = RageUI.CreateMenu("", "Gestion", 0.0, 0.0, "root_cause", "shopui_title_premiumdeluxe")
    local gestionmenu_stock = RageUI.CreateSubMenu(gestionmenu_main, "", "Gestion", 0.0, 0.0, "root_cause",
        "shopui_title_premiumdeluxe")
    local gestionmenu_sell = RageUI.CreateSubMenu(gestionmenu_stock, "", "Gestion", 0.0, 0.0, "root_cause",
        "shopui_title_premiumdeluxe")
    local gestionmenu_select_buyer = RageUI.CreateSubMenu(gestionmenu_sell, "", "Gestion", 0.0, 0.0, "root_cause",
        "shopui_title_premiumdeluxe")
    gestionmenu_main.Closed = function()
        open = false
    end

    local selected_vehicle_sold = {}
    local selected_vehicle_price = 0

    function openGestionMenu()
        if open then
            open = false
            RageUI.Visible(gestionmenu_main, false)
        else
            open = true
            RageUI.Visible(gestionmenu_main, true)
            TriggerServerEvent('core:cardealerGetStock', token, "cardealerSud")

            Citizen.CreateThread(function()
                while open do
                    RageUI.IsVisible(gestionmenu_main, function()
                        RageUI.Button("Gérer le stock", nil, {}, true, {
                            onSelected = function()
                                TriggerServerEvent('core:cardealerGetStock', token, "cardealerSud")
                            end
                        }, gestionmenu_stock)
                    end)
                    RageUI.IsVisible(gestionmenu_stock, function()
                        for k, v in pairs(concessStock) do
                            RageUI.Button(GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(v.name))), nil, {
                                RightLabel = "Acheté: ~g~" .. v.price .. '$'
                            }, true, {
                                onSelected = function()
                                    selected_vehicle_sold = v
                                end
                            }, gestionmenu_sell)
                        end
                    end)
                    RageUI.IsVisible(gestionmenu_sell, function()
                        RageUI.Separator("Vehicule: " ..
                            GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(selected_vehicle_sold.name))))
                        RageUI.Separator("Prix: " .. selected_vehicle_sold.price)
                        RageUI.Button("Revendre le véhicule", nil, {}, true, {
                            onSelected = function()
                                TriggerServerEvent('core:reSellVehicle', token, selected_vehicle_sold.name,
                                    selected_vehicle_sold.price, "cardealerSud")
                                RageUI.GoBack()
                            end
                        })
                    end)
                    Wait(1)
                end
            end)
        end
    end

    local crew_open = false
    local cardealerMenu_giveVehicle = RageUI.CreateMenu("", "Concessionnaire", 0.0, 0.0,
        "root_cause", "shopui_title_premiumdeluxe")
    local cardealerSudMenu_select_color = RageUI.CreateSubMenu(cardealerMenu_giveVehicle, "", "Concessionnaire", 0.0, 0.0,
        "root_cause", "shopui_title_premiumdeluxe")
    local cardealerSudMenu_select_buyer = RageUI.CreateSubMenu(cardealerSudMenu_select_color, "", "Concessionnaire", 0.0, 0.0,
        "root_cause", "shopui_title_premiumdeluxe")
    cardealerMenu_giveVehicle.Closed = function()
        open = false
    end

    local vehicle_selected_to_give = {}
    local plys = {}
    local ACrew = true
    local AJob = false
    function opencardealerSudMenu(AJob, ACrew)
        if open then
            open = false
            RageUI.Visible(cardealerMenu_giveVehicle, false)
        else
            open = true
            RageUI.Visible(cardealerMenu_giveVehicle, true)
            TriggerServerEvent('core:cardealerGetStock', token, "cardealerSud")
            plys = {}
            AJob = AJob
            ACrew = ACrew

            Citizen.CreateThread(function()
                while open do
                    RageUI.IsVisible(cardealerMenu_giveVehicle, function()
                        for k, v in pairs(concessStock) do
                            RageUI.Button(GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(v.name))), nil, {}, true
                                , {
                                    onSelected = function()
                                        vehicle_selected_to_give = v
                                    end
                                }, cardealerSudMenu_select_color)
                        end
                    end)
                    RageUI.IsVisible(cardealerSudMenu_select_color, function()
                        RageUI.Separator("Vehicule: " ..
                            GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(vehicle_selected_to_give.name))))
                        RageUI.Separator("Prix: " .. vehicle_selected_to_give.price)
                        for k, v in pairs(colors_list) do
                            RageUI.Button("Couleur " .. v.name, nil, {}, true, {
                                onSelected = function()
                                    color = v.id
                                    print(color)
                                    GetAllPlayersInAreaWithDataConcess()
                                end
                            }, cardealerSudMenu_select_buyer)
                        end
                    end)
                    RageUI.IsVisible(cardealerSudMenu_select_buyer, function()
                        if plys then
                            for k, v in pairs(plys) do
                                RageUI.Button("~o~" .. v.player .. "~s~ | ~o~" .. v.name, nil, {}, true, {
                                    onSelected = function()
                                        if ACrew and not AJob then
                                            TriggerServerEvent('core:assignBuyerToVehicle', token,
                                                vehicle_selected_to_give, v.player, v.crew, color, "aucun", "cardealerSud")
                                            RageUI.CloseAll()
                                            open = false
                                        elseif AJob and not ACrew then
                                            TriggerServerEvent('core:assignBuyerToVehicle', token,
                                                vehicle_selected_to_give, v.player, v.crew, color, v.job, "cardealerSud")
                                            RageUI.CloseAll()
                                            open = false
                                        else
                                            TriggerServerEvent('core:assignBuyerToVehicle', token,
                                                vehicle_selected_to_give, v.player, "None", color, "aucun", "cardealerSud")
                                            RageUI.CloseAll()
                                            open = false
                                        end
                                    end
                                }, nil)
                            end
                        else
                            RageUI.Button("Aucun joueur dans la zone", nil, {}, true, {})
                        end
                    end)
                    Wait(1)
                end
            end)
        end
    end

    function FactureCardealer()
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

    function SetCardealerDuty()
        openRadial = false
        closeUI()
        if not inService then
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez ~s pris ~c votre service"
            })

            TriggerServerEvent('core:DutyOn', p:getJob())
            inService = true
            Wait(5000)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous avez ~s quitté ~c votre service"
            })

            TriggerServerEvent('core:DutyOff', p:getJob())
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

    function OpenCrewVehicle()
        if inService then
            openRadial = false
            closeUI()
            opencardealerSudMenu(false, true)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end
    
    function OpenJobVehicle()
        if inService then
            openRadial = false
            closeUI()
            opencardealerSudMenu(true, false)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end
    
    function ContratCardealer()
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
    
    function OpenPlayerVehicle()
        if inService then
            openRadial = false
            closeUI()
            opencardealerSudMenu(false, false)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous devez ~s prendre votre service"
            })
        end
    end

    function OpencardealerRadial()
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
            closeUI()
            Wait(200)
            CreateThread(function()
                function SubAttribueRadialCarDealer()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "JOUEUR",
                                icon = "assets/svg/radial/player.svg",
                                action = "OpenPlayerVehicle"
                            },
                            {
                                name = "JOB",
                                icon = "assets/svg/radial/job.svg",
                                action = "OpenJobVehicle"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "SubRadialCarDealer"
                            },
                            {
                                name = "CREW",
                                icon = "assets/svg/radial/crew.svg",
                                action = "OpenCrewVehicle"
                            }
                        }, title = "ATTRIBUE" }
                    }));
                end

                function SubRadialCarDealer()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "LISTE",
                                icon = "assets/svg/radial/liste.svg",
                                action = "openStockMenu"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "MainRadialCarDealer"
                            },
                            {
                                name = "ATTRIBUÉ",
                                icon = "assets/svg/radial/add.svg",
                                action = "SubAttribueRadialCarDealer"
                            }
                        }, title = "CLES" }
                    }));
                end
                
                function SubPapierRadialCarDealer()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "CONTRAT",
                                icon = "assets/svg/radial/paper.svg",
                                action = "ContratCardealer"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "MainRadialCarDealer"
                            },
                            {
                                name = "FACTURE",
                                icon = "assets/svg/radial/billet.svg",
                                action = "FactureCardealer"
                            }
                        }, title = "PAPIERS" }
                    }));
                end

                function MainRadialCarDealer()
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
                                name = "PAPIERS",
                                icon = "assets/svg/radial/paper.svg",
                                action = "SubPapierRadialCarDealer"
                            },
                            {
                                name = "PRISE DE SERVICE",
                                icon = "assets/svg/radial/checkmark.svg",
                                action = "SetCardealerDuty"
                            },
                            {
                                name = "CLES",
                                icon = "assets/svg/radial/key.svg",
                                action = "SubRadialCarDealer"
                            }
                        }, title = "LS MOTORS" }
                    }));
                end

                MainRadialCarDealer()
            end)
        else
            openRadial = false
            closeUI()
            return
        end
    end
    
    RegisterJobMenu(OpencardealerRadial)

    zone.addZone("cardealerSud_service", vector3(164.49981689453, -1097.2114257813, 28.21148109436),
        "Appuyer sur ~INPUT_CONTEXT~ pour prendre/quitter votre service", function()
            if not inService then
                -- ShowNotification("~g~Vous avez pris votre service")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'VERT',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous avez ~s pris ~c votre service"
                })

                TriggerServerEvent('core:DutyOn', 'cardealerSud')
                inService = true
                Wait(5000)
            else
                -- ShowNotification("~r~Vous avez quitté votre service")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous avez ~s quitté ~c votre service"
                })

                TriggerServerEvent('core:DutyOff', 'cardealerSud')
                inService = false
                Wait(5000)

            end
        end, false)

    function GetAllPlayersInAreaWithDataConcess()
        local players = GetAllPlayersInArea(p:pos(), 5.0)
        plys = {}

        for k, v in pairs(players) do
            local src = GetPlayerServerId(v)
            local name = TriggerServerCallback("core:GetPlayerAreaName", src)
            local crew = TriggerServerCallback("core:GetPlayerCrewArea", src)
            local job = TriggerServerCallback("core:GetPlayerJobArea", src)
            table.insert(plys, {
                player = src,
                name = name,
                crew = crew,
                job = job
            })
        end
    end
end

function UnloadcardealerSudJob()
    zone.removeZone("concess_gestion")
    zone.removeZone("concess_stock")
    zone.removeZone("cardealerSud_service")
end

local inTryVeh = false
local tryPlate = ""
RegisterNetEvent("core:cardealerSudTryVeh")
AddEventHandler("core:cardealerSudTryVeh", function(model)
    inTryVeh = true
    local vehicle = vehicle.create(model, vector4(131.00651550293, -1094.8093261719, 28.19504737854, 134.02264404297),
        {})
    local plate = vehicle.getProps(vehicle).plate
    local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehicle, VehToNet(vehicle), p:getJob())
    createKeys(plate, model)
    local random = math.random(100,999)
    tryPlate = "ESSAI" .. random
    SetVehicleNumberPlateText(vehicle, "ESSAI" .. random)
    TriggerServerEvent("core:GiveVehicleKeyToPlayer", token, "ESSAI" .. random)
    TaskWarpPedIntoVehicle(p:ped(), vehicle, -1)

    local timer = GetGameTimer() + 60000
    while inTryVeh do
        ShowHelpNotification("Appuyez sur ~INPUT_MULTIPLAYER_INFO~ pour mettre fin au test")
        if GetGameTimer() > timer then
            SetEntityCoords(vehicle, vector3(120.54270935059, -1096.3115234375, 28.195068359375))
            TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
            removeKeys(GetVehicleNumberPlateText(vehicle), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))))
            TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(vehicle))
            DeleteEntity(vehicle)
            -- ShowNotification("~r~Le délai a été dépassé")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "~s Le délai a été dépassé"
            })

            inTryVeh = false
            TriggerServerEvent('core:unsetTryCar', "sud")
            return
        elseif IsControlJustPressed(0, 20) then
            -- ShowNotification("~r~Vous avez annulé le test")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s annulé ~c le test"
            })

            SetEntityCoords(vehicle, vector3(120.54270935059, -1096.3115234375, 28.195068359375))
            TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
            removeKeys(GetVehicleNumberPlateText(vehicle), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))))
            TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(vehicle))
            DeleteEntity(vehicle)
            inTryVeh = false
            TriggerServerEvent('core:unsetTryCar', "sud")
            return
        end
        Wait(0)
    end
end)

RegisterNetEvent("core:spawnVehiclecardealerSud")
AddEventHandler("core:spawnVehiclecardealerSud", function(model, plate, color)
    local boat = false
    local helico = false
    local vehicles
    local spawn
    for key, value in pairs(BateauCatalogue) do
        if value.name == model then
            boat = true
        end
    end
    for key, value in pairs(HelicoCatalogue) do
        if value.name == model then
            helico = true
        end
    end
    if boat then
        vehicles = vehicle.create(model, vector4(-715.96783447266, -1348.1307373047, 0.76020431518555, 140.65835571289),
            {
                plate = plate
            })
    elseif helico then
        vehicles = vehicle.create(model, vector4(-976.44439697266, -2992.9401855469, 14.547943115234, 59.225292205811),
            {
                plate = plate
            })
    else
        if model == "pounder" or model == "mule" or model == "mule2" or model == "mule3" or model == "mule4" or model == "mule5" or model == "benson" or model == "pounder2" then
            spawn = vector4(155.93356323242, -1076.1181640625, 28.207958221436, 89.086090087891)
        else
            spawn = vector4(133.22525024414, -1093.9285888672, 28.195068359375, 117.67794799805)
        end
        vehicles = vehicle.create(model, spawn,
            {
                plate = plate
            })
    end
    TriggerServerEvent("core:SetPropsVeh", token, string.upper(plate), vehicle.getProps(vehicles))
    TriggerServerEvent("core:SetVehicleOut", string.upper(plate), VehToNet(vehicles), vehicle)
    TriggerServerEvent("core:SetPropsVeh", token, string.upper(plate), vehicle.getProps(vehicles))
    SetVehicleDirtLevel(vehicles, 0.0)
end)

function concessFacture(entity)
    local billing_price = 0
    local billing_reason = ""
    local player = NetworkGetPlayerIndexFromPed(entity)
    local sID = GetPlayerServerId(player)
    local price = KeyboardImput("Entrez le prix")
    if price and type(tonumber(price)) == "number" then
        billing_price = tonumber(price)
    end
    local reason = KeyboardImput("Entrez la raison")
    if reason ~= nil then
        billing_reason = tostring(reason)
    end

    if entity == nil then
        local closestPlayer, closestDistance = GetClosestPlayer()
        if closestPlayer ~= nil and closestDistance < 1.5 then
            TriggerServerEvent('core:sendbilling', token, GetPlayerServerId(closestPlayer),
                p:getJob(), billing_price, billing_reason)
        end
    else
        TriggerServerEvent('core:sendbilling', token, sID,
            p:getJob(), billing_price, billing_reason)

        --[[ Ancienne notification
        -- ShowNotification("Facturation envoyée \n Prix : ~g~" ..
            billing_price .. "~s~$ \n Raison : " .. billing_reason)
        --]]

        -- New notif
        exports['vNotif']:createNotification({
            type = 'VERT',
            -- duration = 5, -- In seconds, default:  4
            content = "Facturation envoyée \nPrix : ~s " .. billing_price .. "$ \n~c Raison : ~s " .. billing_reason
        })

    end
end

function showPlate(entity)
    -- show the car's plate
    local plate = GetVehicleNumberPlateText(entity)
    -- ShowNotification("Plaque d'immatriculation : ~g~" .. plate)

    -- New notif
    exports['vNotif']:createNotification({
        type = 'JAUNE',
        -- duration = 5, -- In seconds, default:  4
        content = "Plaque d'immatriculation : ~s " .. plate
    })

end
