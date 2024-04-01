local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local catalogue_item_ltd = {
    headerImage = 'assets/LTD/header_ltd.jpg',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'BOUTIQUE',
    elements = {
        {
            id = 1,
            image = 'assets/LTD/Bouteille_eau.png',
            price = 42,
            subCategory = 'ACHAT RAPIDE',
            item = "water",
            label = "Bouteille d'eau"
        },
        {
            id = 2,
            image = 'assets/LTD/Sandwich_triangle.png',
            price = 68,
            subCategory = 'ACHAT RAPIDE',
            item = "triangle",
            label = "Sandwich triangle"
        },
        {
            id = 3,
            image = 'assets/LTD/GPS.png',
            price = 225,
            subCategory = 'ACHAT RAPIDE',
            item = "gps",
            label = "GPS"
        },

        --{
            --    id = 1,
            --    image = 'assets/LTD/ordinateur.png',
            --    label = 'Ordinateur',
            --    subCategory = 'CATALOGUE LTD',
            --    item = "laptop"
            --},

        {
            id= 1,
            image = 'assets/LTD/Chips.png',
            label = 'Chips',
            item = 'Chips',
            price = 50,
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 1,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Sucette.webp',
            label = 'Sucette',
            item = "lollipop",
            price = 68,
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 1,
            image = 'assets/LTD/surfboard.webp',
            label = 'Planche de surf',
            item = "surfboard",
            price = 750,
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 1,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Glace_a_l_italienne.webp',
            label = 'Glace a l\'Italienne',
            item = "GlaceItalienne",
            price = 75,
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 1,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Barre_de_cereale.webp',
            label = 'Barre Céréales',
            item = "BarreCereale",
            price = 74,
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 1,
            image = 'assets/LTD/cigarettes.png',
            label = 'Cigarette',
            price = 76,
            subCategory = 'ACHAT RAPIDE',
            item = "cig"
        },
        {
            id = 1,
            price = 250,
            image = 'assets/LTD/Ciseaux.png',
            label = 'Ciseaux',
            subCategory = 'ACHAT RAPIDE',
            item = "scisor"
        }, 
        {
            id = 1,
            price = 250,
            image = 'assets/LTD/Pince_a_cheveux.png',
            label = 'Pince à cheveux',
            subCategory = 'ACHAT RAPIDE',
            item = "pince"
        }, 
        {
            id = 1,
            price = 150,
            label = 'Outils de crochetage',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Utils/Outils_crochetage.webp',
            subCategory = 'ACHAT RAPIDE',
            item = "crochet"
        },
        {
            id = 1,
            image = 'assets/LTD/Radio.png',
            label = 'Radio',
            price = 250,
            subCategory = 'ACHAT RAPIDE',
            item = "radio"
        },
        {
            id = 1,
            image = 'assets/LTD/Recycleur.png',
            label = 'Recycleur',
            price = 1250,
            subCategory = 'ACHAT RAPIDE',
            item = "recycleur"
        }, {
            id = 1,
            image = 'assets/LTD/Telephone.png',
            label = 'Téléphone',
            price = 550,
            subCategory = 'ACHAT RAPIDE',
            item = "phone"
        }, {
            id = 1,
            image = 'assets/inventory/items/boombox.png',
            label = 'Boombox',
            price = 450,
            subCategory = 'ACHAT RAPIDE',
            item = "boombox"
        },
        {
            id= 12,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/lait_chocolat.webp',
            label= 'Lait Chocolat',
            item= 'laitchoco',
            price = 64,
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id= 13,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Bouteille_petillante.webp',
            label= 'Eau Pétillante',
            item= 'eaupetillante',
            price = 54,
            subCategory = 'ACHAT RAPIDE',
        },

        {
            id= 13,
            image = 'assets/inventory/items/can.png',
            label= 'Canette vide',
            price = 25,
            item= 'can',
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 1,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/spray.webp',
            label = 'Bombe de peinture',
            price = 250,
            subCategory = 'ACHAT RAPIDE',
            item = 'spray',
        },
        {
            id = 14,
            image = 'assets/inventory/items/umbrella.png',
            label = 'Parapluie',
            price = 216,
            item = "umbrella",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 14,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/malettecuir.webp',
            label = 'Malette en Cuir',
            item = "malettecuir",
            price = 912,
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 1,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/VespucciBike/BMX.webp',
            label="BMX",
            item = "bike",
            price = 500,
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 15,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/bloc_note.webp',
            price = 143,
            label = 'Bloc-note',
            item = "blocnote",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 16,
            image = 'assets/inventory/items/jumelle.png',
            price = 736,
            label = 'Jumelle',
            item = "jumelle",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 17,
            image = 'assets/inventory/items/fishroad.png',
            label = 'Canne Pêche',
            price = 320,
            item = "fishroad",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 18,
            image = 'assets/inventory/items/cigar.png',
            label = 'Cigar',
            price = 60,
            item = "cigar",
            subCategory = 'ACHAT RAPIDE',
        },

--[[         {
            id = 19,
            image = 'assets/inventory/items/Gadget_parachute.png',
            label = 'Parachute',
            item = "Gadget_parachute",
            subCategory = 'ACHAT RAPIDE',
        }, ]]

        {
            id = 20,
            image = 'assets/inventory/items/cleaner.png',
            label = 'Cleaner',
            price = 72,
            item = "cleaner",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 21,
            image = 'assets/inventory/items/sactete.png',
            label = 'Sacs',
            price = 60,
            item = "sactete",
            subCategory = 'ACHAT RAPIDE',
        },
    },
}

local catalogue_item_don = {
    headerImage = 'assets/headers/header_donscountrystore.jpg',
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'BOUTIQUE',
    elements = {
        {
            id = 1,
            image = 'assets/LTD/Bouteille_eau.png',
            price = 42,
            subCategory = 'ACHAT RAPIDE',
            item = "water",
            label = "Bouteille d'eau"
        },
        {
            id = 2,
            image = 'assets/LTD/Sandwich_triangle.png',
            price = 68,
            subCategory = 'ACHAT RAPIDE',
            item = "triangle",
            label = "Sandwich triangle"
        },
        {
            id = 3,
            image = 'assets/LTD/GPS.png',
            price = 225,
            subCategory = 'ACHAT RAPIDE',
            item = "gps",
            label = "GPS"
        },
        {
            id = 1,
            image = 'assets/LTD/Chips.png',
            label = 'Chips',
            price = 50,
            subCategory = 'ACHAT RAPIDE',
            item = "Chips"
        },
        {
            id = 1,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/VespucciBike/BMX.webp',
            label="BMX",
            item = "bike",
            price = 500,
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 1,
            image = 'assets/LTD/surfboard.webp',
            label = 'Planche de surf',
            item = "surfboard",
            price = 750,
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 1,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Sucette.webp',
            label = 'Sucette',
            price = 68,
            item = "lollipop",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 1,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Glace_a_l_italienne.webp',
            label = 'Glace a l\'Italienne',
            price = 75,
            item = "GlaceItalienne",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 1,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Barre_de_cereale.webp',
            label = 'Barre Céréales',
            price = 74,
            item = "BarreCereale",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 1,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/twinkies.webp',
            label = 'Twinkies',
            price = 74,
            item = "twinkies",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 1,
            image = 'assets/LTD/cigarettes.png',
            label = 'Cigarette',
            price = 76,
            subCategory = 'ACHAT RAPIDE',
            item = "cig"
        }, 
        {
            id = 1,
            image = 'assets/LTD/Ciseaux.png',
            label = 'Ciseaux',
            price = 250,
            subCategory = 'ACHAT RAPIDE',
            item = "scisor"
        }, 
        {
            id = 1,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Entreprise/Bennys/PostOP/spray.webp',
            label = 'Bombe de peinture',
            price = 250,
            subCategory = 'ACHAT RAPIDE',
            item = 'spray',
        },
        --{
           -- id = 1,
           -- image = 'assets/LTD/ordinateur.png',
           -- label = 'Ordinateur',
           -- subCategory = 'CATALOGUE LTD',
           -- item = "laptop"
       -- }, 
        {
            id = 1,
            image = 'assets/LTD/Pince_a_cheveux.png',
            label = 'Pince à cheveux',
            price = 250,
            subCategory = 'ACHAT RAPIDE',
            item = "pince"
        }, 
        {
            id = 1,
            image = 'assets/LTD/Radio.png',
            label = 'Radio',
            price = 250,
            subCategory = 'ACHAT RAPIDE',
            item = "radio"
        },
        {
            id = 1,
            price = 150,
            label = 'Outils de crochetage',
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Tablette/Utils/Outils_crochetage.webp',
            subCategory = 'ACHAT RAPIDE',
            item = "crochet"
        },
--[[         {
            id = 1,
            image = 'assets/LTD/Recycleur.png',
            label = 'Recycleur',
            subCategory = 'ACHAT RAPIDE',
            item = "recycleur"
        },  ]]
        {
            id = 1,
            image = 'assets/LTD/Telephone.png',
            label = 'Téléphone',
            price = 550,
            subCategory = 'ACHAT RAPIDE',
            item = "phone"
        },{
            id = 1,
            image = 'assets/inventory/items/boombox.png',
            label = 'Boombox',
            subCategory = 'ACHAT RAPIDE',
            price = 450,
            item = "boombox"
        },
        {
            id= 12,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/lait_chocolat.webp',
            label= 'Lait Chocolat',
            item= 'laitchoco',
            price = 64,
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id= 13,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/Bouteille_petillante.webp',
            label= 'Eau Pétillante',
            price = 54,
            item= 'eaupetillante',
            subCategory = 'ACHAT RAPIDE',
        },

        {
            id= 13,
            image = 'assets/inventory/items/can.png',
            label= 'Canette vide',
            price = 25,
            item= 'can',
            subCategory = 'ACHAT RAPIDE',
        },


        {
            id = 14,
            image = 'assets/inventory/items/umbrella.png',
            label = 'Parapluie',
            price = 216,
            item = "umbrella",
            subCategory = 'ACHAT RAPIDE',
        },

        {
            id = 14,
            image= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/malettecuir.webp',
            label = 'Malette en Cuir',
            item = "malettecuir",
            price = 912,
            subCategory = 'ACHAT RAPIDE',
        },

        {
            id = 15,
            image = 'https://assets-vision-fa.cdn.purplemaze.net/assets/Restaurant/ltd/bloc_note.webp',
            label = 'Bloc-note',
            price = 143,
            item = "blocnote",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 16,
            image = 'assets/inventory/items/jumelle.png',
            label = 'Jumelle',
            price = 736,
            item = "jumelle",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 17,
            image = 'assets/inventory/items/fishroad.png',
            label = 'Canne Pêche',
            price = 320,
            item = "fishroad",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 18,
            image = 'assets/inventory/items/cigar.png',
            label = 'Cigar',
            price = 60,
            item = "cigar",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 19,
            image = 'assets/inventory/items/Gadget_parachute.png',
            label = 'Parachute',
            price = 1300,
            item = "gadget_parachute",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 20,
            image = 'assets/inventory/items/cleaner.png',
            label = 'Cleaner',
            price = 72,
            item = "cleaner",
            subCategory = 'ACHAT RAPIDE',
        },
        {
            id = 21,
            image = 'assets/inventory/items/sactete.png',
            label = 'Sacs',
            price = 60,
            item = "sactete",
            subCategory = 'ACHAT RAPIDE',
        },

    },
}

--RegisterCommand("ltd", function(source, args, rawCommand)
function openStore(ped, job)
    -- exports['tuto-fa']:GotoStep(6)
    pedCoords = GetEntityCoords(ped)
    playerCoords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamActive(cam, 1)
    SetCamCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.7)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, pedCoords.x, pedCoords.y, pedCoords.z + 0.5)
    RenderScriptCams(true, 0, 3000, 1, 0)   
    FreezeEntityPosition(PlayerPedId(), true)
    if job == "don" then
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuLTD',
            data = catalogue_item_don
        }));
    else
        SendNuiMessage(json.encode({
            type = 'openWebview',
            name = 'MenuLTD',
            data = catalogue_item_ltd
        }));
    end
end
--end, false)
local AntiSpamLTD = true

RegisterNUICallback("MenuLTD", function(data, cb)
    local ltdMirrorService = TriggerServerCallback("core:getNumberOfDuty", token, 'ltdmirror')
    local ltdSudService = TriggerServerCallback("core:getNumberOfDuty", token, 'ltdsud')
    local donService = TriggerServerCallback("core:getNumberOfDuty", token, 'don')

    print(ltdMirrorService)
    print(ltdSudService)
    print(donService)

    if ltdMirrorService == 0 and ltdSudService == 0 and donService == 0 then
        if p:pay(data.price) and AntiSpamLTD then
            AntiSpamLTD = false
            TriggerSecurGiveEvent("core:addItemToInventory", token, data.item, 1, {})
            -- ShowNotification("Vous venez d'acheter un(e) "..data.name)

            -- New notif
            exports['vNotif']:createNotification({
                type = 'DOLLAR',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous venez d'acheter ~s un(e) "..data.label
            })
            Wait(200)
            AntiSpamLTD = true
        end
    else 
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "Un magasin est actuellement ouvert !"
        })
    end
end)

RegisterNUICallback("focusOut", function (data, cb)
    TriggerScreenblurFadeOut(0.5)
    openRadarProperly()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    FreezeEntityPosition(PlayerPedId(), false)
end)

--[[
    Ped into illegal

    ./core/addon/illegal/new_superette.lua
]]--