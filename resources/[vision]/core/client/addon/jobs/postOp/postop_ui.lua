local token = nil 
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local PostOPShop = {
    open = false,
    cam = nil,    
}

DataSendPostOP = {
    catalogue = {},
    buttons = {
        {
            name = 'Nourritures',
            width = 'full',
            image = 'assets/svg/radial/carton.svg',
            hoverStyle = 'fill-black stroke-black',
        },
        {
            name = 'Boissons',
            width = 'full',
            image = 'assets/svg/radial/carton.svg',
            hoverStyle = 'fill-black stroke-black',
        },
        {
            name = 'Alcool',
            width = 'full',
            image = 'assets/svg/radial/carton.svg',
            hoverStyle = 'fill-black stroke-black',
        },
        {
            name = 'Utilitaires',
            width = 'full',
            image = 'assets/svg/radial/carton.svg',
            hoverStyle = 'fill-black stroke-black',
        },
    },
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'Stock',
    headerImage = 'assets/headers/header_postop.jpg',
    callbackName = 'Menu_postop_previewjob_callback',
    -- preset ='stockEntreprise',
    showTurnAroundButtons = false
}

DataSendDomaine = {
    catalogue = {},
    buttons = {
        {
            name = 'Alcool',
            width = 'full',
            image = 'assets/svg/radial/carton.svg',
            hoverStyle = 'fill-black stroke-black',
        },
    },
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'Stock',
    headerImage = 'assets/headers/header_domaine.jpg',
    callbackName = 'Menu_postop_previewjob_callback',
    -- preset ='stockEntreprise',
    showTurnAroundButtons = false
}


local function getPlayerJobData(name)
    return PostOpSocietysStockage[name]
end

RegisterNUICallback("Menu_postop_entreprise_callback", function(data)
    print("Menu_postop_entreprise_callback, data", json.encode(data))

    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
    Wait(50)
    PostOPShop.open = true

    local playerJobData = getPlayerJobData(data.itemname)

    print('Catalogue Entreprise : '..data.itemname)


    local generateStorage = true
    if storage and storage.items then generateStorage = false end

    local itemsStorage = {}

    if generateStorage then

        if data.category == 'Nourritures' then
            for i=1, #playerJobData.elements do

                    print(playerJobData.elements[i].id.. ' : '
                    ..playerJobData.elements[i].label..' : '
                    ..playerJobData.elements[i].category)

                    table.insert(itemsStorage, {
                        id = playerJobData.elements[i].id,
                        label = playerJobData.elements[i].label,
                        givename = playerJobData.elements[i].givename,
                        image = playerJobData.elements[i].image,
                        category = playerJobData.elements[i].category,
                        quantity = 0
                    })

            end
        
        elseif data.category == 'Boissons' then
            for i=1, #playerJobData.elementsBoissons do

                    print(playerJobData.elementsBoissons[i].id.. ' : '
                    ..playerJobData.elementsBoissons[i].label..' : '
                    ..playerJobData.elementsBoissons[i].category)

                    table.insert(itemsStorage, {
                        id = playerJobData.elementsBoissons[i].id,
                        label = playerJobData.elementsBoissons[i].label,
                        givename = playerJobData.elementsBoissons[i].givename,
                        image = playerJobData.elementsBoissons[i].image,
                        category = playerJobData.elementsBoissons[i].category,
                        quantity = 0
                    })

            end

        elseif data.category == 'Alcool' then
            for i=1, #playerJobData.elementsAlcool do

                    print(playerJobData.elementsAlcool[i].id.. ' : '
                    ..playerJobData.elementsAlcool[i].label..' : '
                    ..playerJobData.elementsAlcool[i].category)

                    table.insert(itemsStorage, {
                        id = playerJobData.elementsAlcool[i].id,
                        label = playerJobData.elementsAlcool[i].label,
                        givename = playerJobData.elementsAlcool[i].givename,
                        image = playerJobData.elementsAlcool[i].image,
                        category = playerJobData.elementsAlcool[i].category,
                        quantity = 0
                    })
            end

        elseif data.category == 'Utilitaires' then
            for i=1, #playerJobData.elementsUtilitaires do

                    print(playerJobData.elementsUtilitaires[i].id.. ' : '
                    ..playerJobData.elementsUtilitaires[i].label..' : '
                    ..playerJobData.elementsUtilitaires[i].category)

                    table.insert(itemsStorage, {
                        id = playerJobData.elementsUtilitaires[i].id,
                        label = playerJobData.elementsUtilitaires[i].label,
                        givename = playerJobData.elementsUtilitaires[i].givename,
                        image = playerJobData.elementsUtilitaires[i].image,
                        category = playerJobData.elementsUtilitaires[i].category,
                        quantity = 0
                    })

            end
        end
    else
        itemsStorage = storage.items
    end

    if data.category == 'Nourritures' then
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuPostOPStock',
            data = {
                headerImage = 'assets/headers/header_postop.jpg',
                elements = playerJobData.elements,
                stocks = itemsStorage,
                headerIcon = 'assets/icons/market-cart.png',
                headerIconName = 'Stock',
                callbackName = 'Menu_postop_achat_callback'
            }
        }))
    
    elseif data.category == 'Boissons' then
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuPostOPStock',
            data = {
                headerImage = 'assets/headers/header_postop.jpg',
                elements = playerJobData.elementsBoissons,
                stocks = itemsStorage,
                headerIcon = 'assets/icons/market-cart.png',
                headerIconName = 'Stock',
                callbackName = 'Menu_postop_achat_callback'
            }
        }))

    elseif data.category == 'Alcool' then
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuPostOPStock',
            data = {
                headerImage = 'assets/headers/header_postop.jpg',
                elements = playerJobData.elementsAlcool,
                stocks = itemsStorage,
                headerIcon = 'assets/icons/market-cart.png',
                headerIconName = 'Stock',
                callbackName = 'Menu_postop_achat_callback'
            }
        }))

    elseif data.category == 'Utilitaires' then
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuPostOPStock',
            data = {
                headerImage = 'assets/headers/header_postop.jpg',
                elements = playerJobData.elementsUtilitaires,
                stocks = itemsStorage,
                headerIcon = 'assets/icons/market-cart.png',
                headerIconName = 'Stock',
                callbackName = 'Menu_postop_achat_callback'
            }
        }))
    
    end

    forceHideRadar()
    SetNuiFocusKeepInput(true)
    CreateThread(function()
        local disablekeys = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 23, 24, 25, 26, 32, 33, 34, 35, 37, 44, 45, 61, 268,270, 269,266,281,280,278,279,71,72,73,74,77,87,232,62, 63,69, 70, 140, 141, 142, 257, 263, 264}
        while PostOPShop.open do 
            Wait(1)
            for k,v in pairs(disablekeys) do 
                DisableControlAction(0, v, true)
            end
            if IsDisabledControlPressed(0, 38) then 
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+0.8)
            elseif IsDisabledControlPressed(0, 44) then 
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-0.8)
            end
        end
    end)

end)

RegisterNUICallback("Menu_postop_achat_callback", function(data)
    print("Menu_postop_achat_callback, data", json.encode(data))


    local totalprice = 0

    itemstaked = {}
    

    for k, v in pairs(data.items) do
                
        TriggerSecurGiveEvent("core:addItemToInventory", token, v.givename, v.quantity, {})

        -- Affiche les prix de chaque items commandé total
--[[         print(v.label .. " : ".. v.price*v.quantity)

        print("-----------------------------------") ]]

        totalprice = totalprice + v.price*v.quantity

        table.insert(itemstaked, {
            items = v.label,
            quantity = v.quantity
        })

        if p:haveItemWithCount(v.givename, v.quantity) then
            TriggerServerEvent("core:paySociety", v.price*v.quantity, p:getJob()) 

            exports['vNotif']:createNotification({
                type = 'DOLLAR',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous venez de récupérer ~s x".. v.quantity .. " " .. v.label
            })
        end

    end

    -- print("itemstaked", json.encode(itemstaked))


    -- print("Total : "..totalprice)

    exports['vNotif']:createNotification({
        type = 'DOLLAR',
        -- duration = 5, -- In seconds, default:  4
        content = "Votre entreprise vient de payer ~s".. totalprice.."$"
    })

    TriggerServerEvent("PostOP:TakeLogs", totalprice, p:getJob(), json.encode(itemstaked)) 

    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))


--[[     if data.reset then -- Reset button (bannière)
        ClearPedTasks(PlayerPedId())
        RenderScriptCams(false, 0, 3000, 1, 0)
    end
    if data.itemname and data.price then 
        --if p:pay(tonumber(data.prix)) then
            TriggerSecurGiveEvent("core:addItemToInventory", token, data.itemname, 1, {})
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez reçu un/une " .. data.label
            })
        --else
        --    exports['vNotif']:createNotification({
        --        type = 'ROUGE',
        --        content = "~c Vous n'avez ~s pas assez d'argent"
        --    })
        --end
    end ]]
end)

RegisterNUICallback("focusOut", function()
    if PostOPShop.open then
        SetNuiFocusKeepInput(false)
        SetNuiFocus(false, false)
        PostOPShop.open = false
    end
end)

RegisterNUICallback("Menu_PostOP_preview_callback", function(data)
end)

local allitems = {

    -- Nourritures
    {
        name = "UwU",
        category = "Nourritures", 
        imagename = "uwu", 
        imagepath = "Entreprises", 
    },
    {
        name = "Burger Shot",
        category = "Nourritures", 
        imagename = "burgershot", 
        imagepath = "Entreprises", 
    },
    {
        name = "Bean Machine",
        category = "Nourritures", 
        imagename = "beanmachine", 
        imagepath = "Entreprises", 
    },
    {
        name = "Le Miroir",
        category = "Nourritures", 
        imagename = "mirror", 
        imagepath = "Entreprises", 
    },
    {
        name = "Unicorn",
        category = "Nourritures", 
        imagename = "unicorn", 
        imagepath = "Entreprises", 
    },
    {
        name = "Yellow Jack",
        category = "Nourritures", 
        imagename = "yellowjack", 
        imagepath = "Entreprises", 
    },
    {
        name = "Pops Diner",
        category = "Nourritures", 
        imagename = "pops", 
        imagepath = "Entreprises", 
    },
    {
        name = "Cluckin Bell",
        category = "Nourritures", 
        imagename = "cluckin", 
        imagepath = "Entreprises", 
    },
    {
        name = "Comrades Bar",
        category = "Nourritures", 
        imagename = "comrades", 
        imagepath = "Entreprises", 
    },
    {
        name = "Black Wood",
        category = "Nourritures", 
        imagename = "blackwood", 
        imagepath = "Entreprises", 
    },
    {
        name = "Bahamas",
        category = "Nourritures", 
        imagename = "bahamas", 
        imagepath = "Entreprises", 
    },
    {
        name = "Bayview Lodge",
        category = "Nourritures", 
        imagename = "bayviewLodge", 
        imagepath = "Entreprises", 
    },
    {
        name = "LTD Grove Street",
        category = "Nourritures", 
        imagename = "ltdsud", 
        imagepath = "Entreprises", 
    },
    {
        name = "Dons Country Store",
        category = "Nourritures", 
        imagename = "don", 
        imagepath = "Entreprises", 
    },
    {
        name = "Pizzeria",
        category = "Nourritures", 
        imagename = "pizzeria", 
        imagepath = "Entreprises", 
    },
    {
        name = "Pearl",
        category = "Nourritures", 
        imagename = "pearl", 
        imagepath = "Entreprises", 
    },
    {
        name = "Up'n Atom",
        category = "Nourritures", 
        imagename = "upnatom", 
        imagepath = "Entreprises", 
    },
    {
        name = "Horny's",
        category = "Nourritures", 
        imagename = "hornys", 
        imagepath = "Entreprises", 
    },
    {
        name = "Tacos Rancho",
        category = "Nourritures", 
        imagename = "tacosrancho", 
        imagepath = "Entreprises", 
    },

    -- Boissons
    {
        name = "Tacos Rancho",
        category = "Boissons", 
        imagename = "tacosrancho", 
        imagepath = "Entreprises", 
    },
    {
        name = "UwU",
        category = "Boissons", 
        imagename = "uwu", 
        imagepath = "Entreprises", 
    },
    {
        name = "Burger Shot",
        category = "Boissons", 
        imagename = "burgershot", 
        imagepath = "Entreprises", 
    },
    {
        name = "Bean Machine",
        category = "Boissons", 
        imagename = "beanmachine", 
        imagepath = "Entreprises", 
    },
    {
        name = "Le Miroir",
        category = "Boissons", 
        imagename = "mirror", 
        imagepath = "Entreprises", 
    },
    {
        name = "Unicorn",
        category = "Boissons", 
        imagename = "unicorn", 
        imagepath = "Entreprises", 
    },
    {
        name = "Yellow Jack",
        category = "Boissons", 
        imagename = "yellowjack", 
        imagepath = "Entreprises", 
    },
    {
        name = "Pops Diner",
        category = "Boissons", 
        imagename = "pops", 
        imagepath = "Entreprises", 
    },
    {
        name = "Cluckin Bell",
        category = "Boissons", 
        imagename = "cluckin", 
        imagepath = "Entreprises", 
    },
    {
        name = "Comrades Bar",
        category = "Boissons", 
        imagename = "comrades", 
        imagepath = "Entreprises", 
    },
    {
        name = "Black Wood",
        category = "Boissons", 
        imagename = "blackwood", 
        imagepath = "Entreprises", 
    },
    {
        name = "Bahamas",
        category = "Boissons", 
        imagename = "bahamas", 
        imagepath = "Entreprises", 
    },
    {
        name = "Bayview Lodge",
        category = "Boissons", 
        imagename = "bayviewLodge", 
        imagepath = "Entreprises", 
    },

    {
        name = "LTD Grove Street",
        category = "Boissons", 
        imagename = "ltdsud", 
        imagepath = "Entreprises", 
    },
    
    {
        name = "Dons Country Store",
        category = "Boissons", 
        imagename = "don", 
        imagepath = "Entreprises", 
    },
    {
        name = "Pizzeria",
        category = "Boissons", 
        imagename = "pizzeria", 
        imagepath = "Entreprises", 
    },
    {
        name = "Pearl",
        category = "Boissons", 
        imagename = "pearl", 
        imagepath = "Entreprises", 
    },
    {
        name = "Up'n Atom",
        category = "Boissons", 
        imagename = "upnatom", 
        imagepath = "Entreprises", 
    },
    {
        name = "Horny's",
        category = "Boissons", 
        imagename = "hornys", 
        imagepath = "Entreprises", 
    },

    -- Alcool

    {
        name = "Le Miroir",
        category = "Alcool", 
        imagename = "mirror", 
        imagepath = "Entreprises", 
    },
    {
        name = "Unicorn",
        category = "Alcool", 
        imagename = "unicorn", 
        imagepath = "Entreprises", 
    },
    {
        name = "Yellow Jack",
        category = "Alcool", 
        imagename = "yellowjack", 
        imagepath = "Entreprises", 
    },
    {
        name = "Pops Diner",
        category = "Alcool", 
        imagename = "pops", 
        imagepath = "Entreprises", 
    },
    {
        name = "Comrades Bar",
        category = "Alcool", 
        imagename = "comrades", 
        imagepath = "Entreprises", 
    },
    {
        name = "Black Wood",
        category = "Alcool", 
        imagename = "blackwood", 
        imagepath = "Entreprises", 
    },
    {
        name = "Bahamas",
        category = "Alcool", 
        imagename = "bahamas", 
        imagepath = "Entreprises", 
    },
    {
        name = "Bayview Lodge",
        category = "Alcool", 
        imagename = "bayviewLodge", 
        imagepath = "Entreprises", 
    },
    {
        name = "Pearl",
        category = "Alcool", 
        imagename = "pearl", 
        imagepath = "Entreprises", 
    },


    --- Utilitaires

    {
        name = "UwU",
        category = "Utilitaires", 
        imagename = "uwu", 
        imagepath = "Entreprises", 
    },
    {
        name = "LTD Grove Street",
        category = "Utilitaires", 
        imagename = "ltdsud", 
        imagepath = "Entreprises", 
    },
    {
        name = "Dons Country Store",
        category = "Utilitaires", 
        imagename = "don", 
        imagepath = "Entreprises", 
    },

    {
        name = "Yellow Jack",
        category = "Utilitaires", 
        imagename = "yellowjack", 
        imagepath = "Entreprises", 
    },


    -- MECANO

    {
        name = "Bennys",
        category = "Utilitaires", 
        imagename = "bennys", 
        imagepath = "Entreprises", 
    },
    {
        name = "Beekers",
        category = "Utilitaires", 
        imagename = "beekers", 
        imagepath = "Entreprises", 
    },
    {
        name = "Hayes",
        category = "Utilitaires", 
        imagename = "hayes", 
        imagepath = "Entreprises", 
    },
    {
        name = "Sunshine",
        category = "Utilitaires", 
        imagename = "sunshine", 
        imagepath = "Entreprises", 
    },
    {
        name = "Harmony Repair",
        category = "Utilitaires", 
        imagename = "harmony", 
        imagepath = "Entreprises", 
    },
}

function OpenPostOPUI()
    DataSendPostOP.catalogue = {}

    DataSendDomaine.catalogue = {}

    if p:getJob() == "postop" then 
        for k,v in pairs(allitems) do
            table.insert(DataSendPostOP.catalogue, {id = k, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/PostOP/LogoEntreprise/"..v.imagename..".webp", 
            category=v.category, itemname = v.imagename, label = v.name, ownCallbackName= 'Menu_postop_entreprise_callback'})
        end
        DataSendPostOP.disableSubmit = true
    elseif p:getJob() == "domaine" then
        for k,v in pairs(allitems) do
            table.insert(DataSendDomaine.catalogue, {id = k, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/PostOP/LogoEntreprise/"..v.imagename..".webp", 
            category=v.category, itemname = v.imagename, label = v.name, ownCallbackName= 'Menu_postop_entreprise_callback'})
        end
        DataSendDomaine.disableSubmit = true
    end

    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
    Wait(50)
    PostOPShop.open = true

    if p:getJob() == 'postop' then
        SendNUIMessage({
            type = "openWebview",
            name = "MenuGrosCatalogue",
            data = DataSendPostOP
        })
    elseif p:getJob() == 'domaine' then
        SendNUIMessage({
            type = "openWebview",
            name = "MenuGrosCatalogue",
            data = DataSendDomaine
        })
    end
    forceHideRadar()
    SetNuiFocusKeepInput(true)
    CreateThread(function()
        local disablekeys = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 23, 24, 25, 26, 32, 33, 34, 35, 37, 44, 45, 61, 268,270, 269,266,281,280,278,279,71,72,73,74,77,87,232,62, 63,69, 70, 140, 141, 142, 257, 263, 264}
        while PostOPShop.open do 
            Wait(1)
            for k,v in pairs(disablekeys) do 
                DisableControlAction(0, v, true)
            end
            if IsDisabledControlPressed(0, 38) then 
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+0.8)
            elseif IsDisabledControlPressed(0, 44) then 
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-0.8)
            end
        end
    end)
end