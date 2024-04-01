local NUI_CALLBACK_NAME = 'PostOp'

local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local zonePostOP = {
    {
        position = vector3(-429.1029, -2813.2935, 7.2738),
        blip = vector3(-429.1029, -2813.2935, 7.2738)
    }
}

local spawnPlaces = {
    vector4(-454.0602722168, -2794.7995605469, 5.0003209114075, 40.511695861816),
    vector4(-454.66912841797, -2790.2583007813, 5.0003228187561, 45.944828033447),
    vector4(-454.87350463867, -2799.1918945313, 5.0003209114075, 50.334209442139),
    vector4(-459.1672668457, -2803.5229492188, 5.0003447532654, 47.793815612793),
}


local PostOPShop = {
    open = false,
    cam = nil,    
}

local function closeWebViewAndRemoveFocus() 
    SetNuiFocus(false, false)
    SendNuiMessage(json.encode({
        type = 'closeWebview'
    }))
end

function LoadPostOP()

    if pJob ~= "postop" then
        return
    end

    local openRadial = false

    for k, v in pairs(zonePostOP) do
        zone.addZone(
            "PostOP_Stock", -- Nom
            v.position,-- Position
            "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le stock",  -- Text afficher
            function() -- Action qui seras fait
                if not PostOPShop.open then
                    OpenPostOPUI() -- Ouvrir le menu
                end
            end,
            true, -- Avoir un marker ou non
            29, -- Id / type du marker
            0.4, -- La taille
            {50, 168, 82}, -- RGB
            170 -- Alpha
        )
    end

    zone.addZone("PostOP_DelVeh", vector3(-468.37576293945, -2812.4213867188, 6.0003266334534),
    "Appuyer sur ~INPUT_CONTEXT~ pour ranger le véhicule", function()
        if IsPedInAnyVehicle(p:ped(), false) then
            if GetVehicleBodyHealth(p:currentVeh()) / 10 >= 80 or
                GetVehicleEngineHealth(p:currentVeh()) / 10 >=
                80 then
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
    end, true, 36, 0.5, { 255, 0, 0 }, 255)

    local postoplVeh = {
        headerImage = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_postop.webp',
        headerIcon = 'assets/icons/voiture-icon.png',
        headerIconName = 'VEHICULES',
        callbackName = 'postopVehicle',
        elements = {
            {
                id = 1,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/PostOP/boxville7.webp',
                label = 'Boxville',
                name = "boxville7"
            },
            {
                id = 2,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/PostOP/nspeedo.webp',
                label = 'NSpeedo',
                name = "nspeedo"
            },
            {
                id = 3,
                image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/PostOP/pounder3.webp',
                label = 'Pounder',
                name = "pounder3"
            },
        }
    }

    function OpenMenuVehPostOP()
        forceHideRadar()
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuCatalogue',
            data = postoplVeh
        }))
    end

    zone.addZone("PostOP_Veh",
        vector3(-444.17849731445, -2799.4118652344, 6.396055316925),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        function()
            if PostOP.Duty then
                MenuChoose = "car"
                OpenMenuVehPostOP()
            else
                exports['vNotif']:createNotification({
                    type = 'ROUGE',
                    content = "Vous devez ~s prendre votre service"
                })
            end
        end,            
        true, -- Avoir un marker ou non
        23, -- Id / type du marker
        0.5, -- La taille
        {50, 168, 82}, -- RGB
        170 -- Alpha
    )

    zone.addZone(
        "coffre_PostOP", vector3(-430.85388183594, -2802.6911621094, 6.2772393226624),
        "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le coffre de l'entreprise",
        function()
            OpenInventorySocietyMenu() --TODO: fini le menu society
        end,
        true,
        25, -- Id / type du marker
        0.6, -- La taille
        { 51, 204, 255 }, -- RGB
        170-- Alpha
    )

    --for k, v in pairs(-431.0583190918, -2802.6081542969, 7.2779030799866) do
        zone.addZone(
            "casierpostop",
            vector3(-428.67761230469, -2793.5393066406, 5.5357885360718),
            "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir les casiers",
            function()
                OpenPostopCasier() --TODO: fini le menu society
            end,
            false,
            25, -- Id / type du marker
            0.6, -- La taille
            { 51, 204, 255 }, -- RGB
            170-- Alpha
        )
    --end
    local casierOpen = false
    function OpenPostopCasier()
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

    function CreateAdvert()
        if PostOP.Duty then
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

    function SetPostOPDuty()
        openRadial = false
        closeUI()
        if not PostOP.Duty then
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez ~s pris ~c votre service"
            })

            TriggerServerEvent('core:DutyOn', pJob)
            PostOP.Duty = true
            Wait(5000)
        else
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                content = "Vous avez ~s quitté ~c votre service"
            })

            TriggerServerEvent('core:DutyOff', pJob)
            PostOP.Duty = false
            Wait(5000)
        end
    end



    local openRadial = false

    function OpenRadialPostOP()
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

                function OpenMainRadialPostOP()
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
                                action = "OpenRadialPostOPFacture"
                            },
                            {
                                name = "PRISE DE SERVICE",
                                icon = "assets/svg/radial/checkmark.svg",
                                action = "SetPostOPDuty"
                            },
                            {
                                name = "COMMANDES",
                                icon = "assets/svg/radial/paper.svg",
                                action = "handleOpenMenu"
                            }
                        }, title = "PostOP" }
                    }));
                end

                function OpenRadialPostOPFacture()
                    SendNuiMessage(json.encode({
                        type = 'openWebview',
                        name = 'RadialMenu',
                        data = { elements = {
                            {
                                name = "Civil",
                                icon = "assets/svg/radial/billet.svg",
                                action = "FacturePostOPCivil"
                            },
                            {
                                name = "Entreprise",
                                icon = "assets/svg/radial/billet.svg",
                                action = "FacturePostOPEntreprise"
                            },
                            {
                                name = "RETOUR",
                                icon = "assets/svg/radial/leave.svg",
                                action = "OpenMainRadialPostOP"
                            },
                        }, title = "PostOP" }
                    }));
                end

                OpenMainRadialPostOP()

            end)
        else
            openRadial = false
            closeUI()
            return
        end
    end

    RegisterJobMenu(OpenRadialPostOP)

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


end



function UnLoadPostOP()
    -- body
    zone.removeZone("PostOP_DelVeh")
    zone.removeZone("PostOP_Stock")
    zone.removeZone("PostOP_Veh")
    zone.removeZone("coffre_PostOP")
end


RegisterNUICallback("postopVehicle", function (data, cb)

    vehs = nil

    for k, v in pairs(spawnPlaces) do
        if vehicle.IsSpawnPointClear(vector3(v.x, v.y, v.z), 3.0) then
            vehs = vehicle.create(data.name, vector4(v), {})
            
            if data.name == 'boxville7' then
                SetVehicleLivery(vehs, 1)
            elseif data.name == 'nspeedo' then
                SetVehicleLivery(vehs, 4)
            elseif data.name == 'pounder3' then
                SetVehicleLivery(vehs, 0)
            end

            local plate = vehicle.getProps(vehs).plate
            local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehs)))
            local newVeh = TriggerServerCallback("core:NewVehJob", plate, model, vehs, VehToNet(vehs), p:getJob())
            createKeys(plate, model)
            
            SendNuiMessage(json.encode({
                type = 'closeWebview',
            }))
            return
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

function handleOpenMenu()
    local playerJob = p:getJob()
    if(playerJob == 'postop' or playerJob == 'domaine' ) then
        openRadial = false
        closeUI()
        TriggerServerEvent(PostOpEvents.GET_ALL_COMMANDS)
    end
end 



RegisterNetEvent('__proxyCommands')
AddEventHandler('__proxyCommands', function(commands)
    

    local commandsToSend = {
        orders = {}
    }

    if p:getJob() == 'postop' then
        commandsToSend.headerImage = "assets/MenuPostOp/header.png"
    else
        commandsToSend.headerImage = "https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_vignoble.webp"
    end

    for k, v in pairs(commands) do
        local formatedItemsWithName = {}

        local CMDdecoded = json.decode(v.items)

        for i=1, #CMDdecoded do

            table.insert(formatedItemsWithName, {
                quantity = CMDdecoded[i].quantity,
                name = CMDdecoded[i].label,
                id = CMDdecoded[i].id
            })

        end

        -- print("----------")

        -- print(formatedItemsWithName .. "TEST PRINT CLIENT SIDE TO SERVER SIDE")

        -- TriggerServerEvent('PostOP::PrintClientSide', formatedItemsWithName)


        table.insert(commandsToSend.orders, {
            id = v.id,
            state = v.state,
            from = v.society,
            phone = v.phone,
            icon = v.icon or 'assets/MenuPostOp/food.png',
            totalprice = v.total,
            content = formatedItemsWithName
        })
    end


     SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'MenuPostOp',
        data = commandsToSend
    }))
end)

local function getPlayerJobData(name)
    return SocietysStockage[name]
end

RegisterNetEvent('__resWithSocietyStorageAndOpenStockMenu')
AddEventHandler('__resWithSocietyStorageAndOpenStockMenu', function(storage)
    local playerJob = p:getJob()
    local playerJobData = getPlayerJobData(playerJob)
    local _headerImage = playerJobData.headerImage
    local _headerIcon = playerJobData.headerIcon
    local _headerIconName = playerJobData.headerIconName
    local _callbackName = PostOpEvents.VALIDATE_MENU_COMMAND


    local generateStorage = true
    if storage and storage.items then generateStorage = false end

    local itemsStorage = {}

    if generateStorage then
        for i=1, #playerJobData.elements do
            table.insert(itemsStorage, {
                id = playerJobData.elements[i].id,
                label = playerJobData.elements[i].label,
                image = playerJobData.elements[i].image,
                quantity = 0
            })
        end
    else
        itemsStorage = storage.items
    end


    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'MenuStockEntreprise',
        data = {
            headerImage = _headerImage,
            elements = playerJobData.elements,
            stocks = itemsStorage,
            headerIcon = _headerIcon,
            headerIconName = _headerIconName,
            callbackName = _callbackName
        }
    }))
end)


function handleOpenCommandMenu()
    local playerJob = p:getJob()
    local playerJobData = getPlayerJobData(playerJob)
    if not playerJobData then 
        return print(("Could not open the command menu. Invalid job [%s]. You must specify the job data in `stocks.lua`."):format(playerJob))
    end
    closeWebViewAndRemoveFocus()
    TriggerServerEvent('__getSocietyStorageAndOpenStockMenu', playerJob)
end


local function getItemById(society, id)
    for _, item in ipairs(SocietysStockage[society].elements) do
        if item.id == id then
            return item
        end
    end
    return nil
end

RegisterNUICallback(PostOpEvents.VALIDATE_MENU_COMMAND, function(data, cb)
    if not data then return end

    -- items
    -- type: 'commande' | 'gestion'
    local playerJob = p:getJob()
    local playerJobData = getPlayerJobData(playerJob)

    if not playerJobData then 
        return print(("Invalid job: [%s]."):format(playerJob))
    end

    local fullNamePlayerJob = globalData.jobs[p:getJob()].label

    print(fullNamePlayerJob)

    local dataToSend = {
        items = {},
        itemsAlcool = {},
        society = fullNamePlayerJob,
    }

    print(json.encode(data))

    if(data.type == 'commande') then 

        local totalprice = 0

        local AlcoolTotalPrice = 0
    
        for k, v in pairs(data.items) do
            local item = getItemById(playerJob, v.id)

            if item then

                if v.ItemCategory == 'Alcool' then
                    table.insert(dataToSend.itemsAlcool, {
                        quantity = v.quantity,
                        id = v.id,
                        image = v.image,
                        label = v.label,
                        ItemCategory = v.ItemCategory,
                        price = v.price,
    
                    })
                elseif v.ItemCategory ~= 'Alcool' then

                    table.insert(dataToSend.items, {
                        quantity = v.quantity,
                        id = v.id,
                        image = v.image,
                        label = v.label,
                        ItemCategory = v.ItemCategory,
                        price = v.price,

                    })
                end

                -- Affiche les prix de chaque items commandé total
--[[                 print(v.label .. " : ".. v.price*v.quantity)

                print("-----------------------------------") ]]

                totalprice = totalprice + v.price*v.quantity

                if v.ItemCategory == "Alcool" then
                    AlcoolTotalPrice = AlcoolTotalPrice + v.price*v.quantity
                end

--[[ 
                print('----------------------------------------------------------------------')

                print('totalprice : '..totalprice)

                print('AlcoolTotalPrice : '..AlcoolTotalPrice) ]]

                local totalpostop = totalprice - AlcoolTotalPrice

--[[                 print('totalpostop : '..totalpostop)



                print('Calcul : \n Total commande : '..totalprice..'\nTotal Domaine : '..AlcoolTotalPrice..'\nTotal PostOP : '.. totalpostop)

                print('----------------------------------------------------------------------') ]]



                
                if v.ItemCategory == "Nourritures" then
                    dataToSend.fournisseur = "postop"
                    dataToSend.totalcmd = totalpostop or 'Erreur sur le calcul'

                elseif v.ItemCategory == "Boissons" then
                    dataToSend.fournisseur = "postop"
                    dataToSend.totalcmd = totalpostop or 'Erreur sur le calcul'

                elseif v.ItemCategory == "Alcool" then
                    dataToSend.fournisseur = "domaine"
                    dataToSend.totalcmdalcool = AlcoolTotalPrice or 'Erreur sur le calcul'

                elseif v.ItemCategory == "Utilitaires" then
                    dataToSend.fournisseur = "postop"
                    dataToSend.totalcmd = totalpostop or 'Erreur sur le calcul'
                end


            end
        end

        dataToSend.phone = TriggerServerCallback("core:GetPhoneNumber") or 'Pas de téléphone'

        for k, v in pairs(dataToSend.items) do
            print('Items : ' .. v.label .. ' Categorie : ' .. v.ItemCategory)
        end

        for k, v in pairs(dataToSend.itemsAlcool) do
            print('----------------------------------------------------')
            print('Items : ' .. v.label .. ' Categorie : ' .. v.ItemCategory)
        end


    
        TriggerServerEvent(PostOpEvents.ADD_COMMAND_TO_DB, dataToSend)
    end

    if(data.type == 'gestion') then 
        -- 
        for k, v in pairs(data.items) do
            table.insert(dataToSend.items, {
                image = v.image,
                label = v.label,
                price = v.price,
                quantity = v.quantity,
                id = v.id 
            })
        end
    

        TriggerServerEvent(PostOpEvents.SET_SOCIETY_STORAGE, dataToSend)
    end

    closeWebViewAndRemoveFocus()
    cb(true)
end)


RegisterNUICallback(PostOpEvents.SAVE_SOCIETY_STORAGE, function(data, cb)
    if not data then return end

    TriggerServerEvent(PostOpEvents.SAVE_SOCIETY_STORAGE, {
        items = data,
        society = p:getJob()
    })

    cb(true)
end)



RegisterNUICallback(NUI_CALLBACK_NAME, function(data, cb)
    if not data then return end

    if (data.type == 'orderDelivered') then
        TriggerServerEvent(PostOpEvents.APPROVE_ORDER, data.order)
    elseif (data.type == 'orderCanceled') then
        TriggerServerEvent(PostOpEvents.CANCEL_ORDER, data.order)
    end

end)

local function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

-- AddEventHandler(PostOpEvents.OPEN_POSTOP_MENU, handleOpenMenu)
AddEventHandler(PostOpEvents.OPEN_COMMAND_MENU, handleOpenCommandMenu)
--[[Keys.Register("F1", "F1", "Ouvrir le menu de commandes", function()
    handleOpenMenu()
end)]]--



-- ! ONLY FOR DEBUG

--[[ local function makeDebugRadial()
    local radial = {
        title = 'Burger Shot',
        elements = {
            {
                name = 'Annoce',
                icon = 'assets/RadialMenus/billet.svg',
                action = '___'
            },
            {
                name = 'Facture',
                icon = 'assets/RadialMenus/billet.svg',
                action = '___'
            },
            {
                name = 'Prise de service',
                icon = 'assets/RadialMenus/billet.svg',
                action = '___'
            },
            {
                name = 'Commande',
                icon = 'assets/RadialMenus/billet.svg',
                action = 'openCommandMenu'
            }
        }
    }

    SendNUIMessage({
        type = 'openWebview',
        name = 'RadialMenu',
        data = radial
    })
end ]]

-- Citizen.CreateThread(function()
--     print('Hello world')
--     exports['vNotif']:createNotification({
--         type = 'SUCCESS',
--         -- duration = 5, -- In seconds, default:  4
--         content = 'Hello world'
--     })
-- end)
-- Citizen.CreateThread(function()
--     SetTimeout(5000, function()
--         makeDebugRadial()
--     end)
-- end)

