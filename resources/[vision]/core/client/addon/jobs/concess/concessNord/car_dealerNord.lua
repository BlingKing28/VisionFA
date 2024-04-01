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

local gestionSocieteConcessNord = vector3(-235.88067626953, 6225.505859375, 30.944118499756)
local coffreConcessNord = vector3(-212.92304992676, 6250.0405273438, 30.944093704224) -- coffre etp
local gestionConcessConcessNord = vector3(-233.81047058105, 6217.83984375, 30.944072723389)
local serviceConcessNord = vector3(-222.89703369141, 6240.5893554688, 30.944091796875)
local essaievehiculeConcessNord = vector4(-205.68023681641, 6230.5766601563, 30.944095611572, 0)
local spawnBigVehiclesConcessnord = vector4(-198.47758483887, 6243.7329101563, 30.495500564575, 222.24540710449)
local spawnNormalVehiclesConcessnord = vector4(-198.47758483887, 6243.7329101563, 30.495500564575, 222.24540710449)
local concessNordTestDelete = vector3(-237.84963989258, 6233.5532226563, 30.501665115356)

local color = 1
local inService = false
function LoadcardealerNordJob()
    local inService = false
    local openRadial = false

    zone.addZone("concess_delete_test",
        concessNordTestDelete,
        "Appuyer sur ~INPUT_CONTEXT~ pour supprimer le véhicule",
        function()
            if inService then
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if vehicle ~= 0 then
                    TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
                    removeKeys(GetVehicleNumberPlateText(vehicle), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))))
                    TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(vehicle))
                    if GetVehicleNumberPlateText(vehicle) == tryPlate then
                        TriggerServerEvent('core:unsetTryCar', "nord")
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

    zone.addZone("concessnord_gestionsociety", -- Nom
        gestionSocieteConcessNord, -- Position
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
    zone.addZone("concessnord_inventory", -- Nom
        coffreConcessNord, -- Position
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
    zone.addZone("concessnord_gestion", -- Nom
    gestionConcessConcessNord, -- Position
        "Appuyer sur ~INPUT_CONTEXT~ pour interagir", -- Text afficher
        function() -- Action qui seras fait
            if inService then
                openGestionCarDealerMenu()
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

    local function closestPlayer()
        local players = GetActivePlayers()
        local closestDistance = -1
        local closestPlayer = -1
        local ply = PlayerPedId()
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

            CreateThread(function()
                while open do
                    RageUI.IsVisible(stockmenu_main, function()
                        for k, v in pairs(concessNord.vehicle) do
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
                                    selected_vehicle.price, "cardealerNord")

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
                                if not TriggerServerCallback("core:isTryCar", 'nord') then
                                    TriggerServerEvent('core:cardealerTryVeh', token, GetPlayerServerId(closestPlayer),
                                        selected_vehicle.name, "cardealerNord")
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

    RegisterNetEvent("core:cardealerNordGetStock")
    AddEventHandler("core:cardealerNordGetStock", function(data)
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

    function openGestionCarDealerMenu()
        if open then
            open = false
            RageUI.Visible(gestionmenu_main, false)
        else
            open = true
            RageUI.Visible(gestionmenu_main, true)
            TriggerServerEvent('core:cardealerGetStock', token, "cardealerNord")

            CreateThread(function()
                while open do
                    RageUI.IsVisible(gestionmenu_main, function()
                        RageUI.Button("Gérer le stock", nil, {}, true, {
                            onSelected = function()
                                TriggerServerEvent('core:cardealerGetStock', token, "cardealerNord")
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
                                    selected_vehicle_sold.price, "cardealerNord")
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
    local cardealerMenu_select_color = RageUI.CreateSubMenu(cardealerMenu_giveVehicle, "", "Concessionnaire", 0.0, 0.0,
        "root_cause", "shopui_title_premiumdeluxe")
    local cardealerMenu_select_buyer = RageUI.CreateSubMenu(cardealerMenu_select_color, "", "Concessionnaire", 0.0, 0.0,
        "root_cause", "shopui_title_premiumdeluxe")
    cardealerMenu_giveVehicle.Closed = function()
        open = false
    end

    local vehicle_selected_to_give = {}
    local plys = {}
    local ACrew = true
    local AJob = false
    function opencardealerNordMenu(AJob, ACrew)
        if open then
            open = false
            RageUI.Visible(cardealerMenu_giveVehicle, false)
        else
            open = true
            RageUI.Visible(cardealerMenu_giveVehicle, true)
            TriggerServerEvent('core:cardealerGetStock', token, "cardealerNord")
            plys = {}
            AJob = AJob
            ACrew = ACrew

            CreateThread(function()
                while open do
                    RageUI.IsVisible(cardealerMenu_giveVehicle, function()
                        for k, v in pairs(concessStock) do
                            RageUI.Button(GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(v.name))), nil, {}, true
                                , {
                                    onSelected = function()
                                        vehicle_selected_to_give = v
                                    end
                                }, cardealerMenu_select_color)
                        end
                    end)
                    RageUI.IsVisible(cardealerMenu_select_color, function()
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
                            }, cardealerMenu_select_buyer)
                        end
                    end)
                    RageUI.IsVisible(cardealerMenu_select_buyer, function()
                        if plys then
                            for k, v in pairs(plys) do
                                RageUI.Button("~o~" .. v.player .. "~s~ | ~o~" .. v.name, nil, {}, true, {
                                    onSelected = function()
                                        if ACrew and not AJob then
                                            TriggerServerEvent('core:assignBuyerToVehicle', token,
                                                vehicle_selected_to_give, v.player, v.crew, color, "aucun", "cardealerNord")
                                            RageUI.CloseAll()
                                            open = false
                                        elseif AJob and not ACrew then
                                            TriggerServerEvent('core:assignBuyerToVehicle', token,
                                                vehicle_selected_to_give, v.player, v.crew, color, v.job, "cardealerNord")
                                            RageUI.CloseAll()
                                            open = false
                                        else
                                            TriggerServerEvent('core:assignBuyerToVehicle', token,
                                                vehicle_selected_to_give, v.player, "None", color, "aucun", "cardealerNord")
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

    function FactureCardealernord()
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

    function SetCardealerDutyNord()
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
            opencardealerNordMenu(false, true)
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
            opencardealerNordMenu(true, false)
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
            opencardealerNordMenu(false, false)
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
                                action = "SubRadialCarDealerN"
                            },
                            {
                                name = "CREW",
                                icon = "assets/svg/radial/crew.svg",
                                action = "OpenCrewVehicle"
                            }
                        }, title = "ATTRIBUE" }
                    }));
                end

                function SubRadialCarDealerN()
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
                
                function SubPapierRadialCarDealerN()
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
                                action = "FactureCardealernord"
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
                                action = "SubPapierRadialCarDealerN"
                            },
                            {
                                name = "PRISE DE SERVICE",
                                icon = "assets/svg/radial/checkmark.svg",
                                action = "SetCardealerDutyNord"
                            },
                            {
                                name = "CLES",
                                icon = "assets/svg/radial/key.svg",
                                action = "SubRadialCarDealerN"
                            }
                        }, title = "AMERICAN MOTORS" }
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

    zone.addZone("cardealerNord_service", serviceConcessNord,
        "Appuyer sur ~INPUT_CONTEXT~ pour prendre/quitter votre service", function()
            if not inService then
                -- ShowNotification("~g~Vous avez pris votre service")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'VERT',
                    -- duration = 5, -- In seconds, default:  4
                    content = "Vous avez ~s pris ~c votre service"
                })

                TriggerServerEvent('core:DutyOn', p:getJob())
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

                TriggerServerEvent('core:DutyOff', p:getJob())
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

function UnloadcardealerNordJob()
    zone.removeZone("concessnord_gestion")
    zone.removeZone("concessnord_inventory")
    zone.removeZone("concessnord_gestionsociety")
    zone.removeZone("cardealerNord_service")
end

local inTryVeh = false
local tryPlate = ""

RegisterNetEvent("core:cardealerNordTryVeh")
AddEventHandler("core:cardealerNordTryVeh", function(model)
    inTryVeh = true
    local vehicle = vehicle.create(model, essaievehiculeConcessNord,
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
            SetEntityCoords(vehicle, essaievehiculeConcessNord.x, essaievehiculeConcessNord.y, essaievehiculeConcessNord.z)
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
            TriggerServerEvent('core:unsetTryCar', "nord")

            return
        elseif IsControlJustPressed(0, 20) then
            -- ShowNotification("~r~Vous avez annulé le test")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s annulé ~c le test"
            })

            SetEntityCoords(vehicle, essaievehiculeConcessNord.x, essaievehiculeConcessNord.y, essaievehiculeConcessNord.z)
            TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
            removeKeys(GetVehicleNumberPlateText(vehicle), GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))))
            TriggerServerEvent("core:removeVeh", GetVehicleNumberPlateText(vehicle))
            DeleteEntity(vehicle)
            inTryVeh = false
            TriggerServerEvent('core:unsetTryCar', "nord")
            return
        end
        Wait(0)
    end
end)

RegisterNetEvent("core:spawnVehiclecardealerNord")
AddEventHandler("core:spawnVehiclecardealerNord", function(model, plate, color)
    local vehicles
    local spawn
    if model == "pounder" or model == "mule" or model == "mule2" or model == "mule3" or model == "mule4" or model == "mule5" or model == "benson" then
        spawn = spawnBigVehiclesConcessnord
    else
        spawn = spawnNormalVehiclesConcessnord
    end
    vehicles = vehicle.create(model, spawn,
        {
            plate = plate
        })
    TriggerServerEvent("core:SetPropsVeh", token, string.upper(plate), vehicle.getProps(vehicles))
    TriggerServerEvent("core:SetVehicleOut", string.upper(plate), VehToNet(vehicles), vehicle)
    SetVehicleDirtLevel(vehicles, 0.0)
end)

function concessNordFacture(entity)
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