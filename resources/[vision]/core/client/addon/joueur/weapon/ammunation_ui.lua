local zoneAmmunation = {
    {
        position =
            vector3(16.340728759766, -1109.4506835938, 29.797199249268),
        blip =
            vector3(12.806353569031, -1102.8748779297, 29.797027587891),
    }
}

local zoneAmmunationNord = {
    {
        position =
            vector3(1695.6677246094, 3757.0515136719, 34.70532989502),
        blip =
            vector3(1695.6677246094, 3757.0515136719, 34.70532989502),
    }
}

local token 
TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local AmmuShop = {
    open = false,
    cam = nil,    
}

DataSendAmmu = {
    catalogue = {},
    buttons = {
        {
            name = 'Pistolets',
            width = 'full',
            image = 'assets/svg/ammunation/pistol.svg',
            hoverStyle = 'fill-black stroke-black',
        },
        --{
        --    name = 'Armes automatiques',
        --    width = 'full',
        --    image = 'assets/svg/ammunation/mitraillette.svg',
        --    hoverStyle = 'fill-black stroke-black',
        --},
        {
            name = 'Armes lourdes',
            width = 'full',
            image = 'assets/svg/ammunation/fusil.svg',
            hoverStyle = 'fill-black stroke-black',
        },
        {
            name = 'Armes blanches',
            width = 'full',
            image = 'assets/svg/ammunation/armeblanche.svg',
            hoverStyle = 'fill-black stroke-black',
        },
        {
            name = 'Utilitaire',
            width = 'full',
            image = 'assets/svg/ammunation/explosif.svg',
            hoverStyle = 'fill-black stroke-black',
        },
    },
    headerIcon = 'assets/icons/market-cart.png',
    headerIconName = 'Ammunation',
    headerImage = 'assets/headers/header_ammu.jpg',
    callbackName = 'Menu_ammu_achat_callback',
    showTurnAroundButtons = false
}

RegisterNUICallback("Menu_ammu_achat_callback", function(data)
    print("Menu_ammu_achat_callback, data", json.encode(data))
    if data.reset then -- Reset button (bannière)
        ClearPedTasks(PlayerPedId())
    end
    if data.itemname and data.price then 
        --if p:pay(tonumber(data.prix)) then
            TriggerSecurGiveEvent("core:addItemToInventory", token, data.itemname, 1, {})
            exports['vNotif']:createNotification({
                type = 'VERT',
                content = "Vous avez reçu un/une " .. data.label
            })


            TriggerServerEvent("core:ammunationtake", data.price, p:getJob(), data.label) 
            --else
        --    exports['vNotif']:createNotification({
        --        type = 'ROUGE',
        --        content = "~c Vous n'avez ~s pas assez d'argent"
        --    })
        --end
    end
end)

RegisterNUICallback("focusOut", function()
    if AmmuShop.open then
        SetNuiFocusKeepInput(false)
        SetNuiFocus(false, false)
        AmmuShop.open = false
    end
end)

RegisterNUICallback("Menu_Ammu_preview_callback", function(data)
end)

local allweapons = {
    {name = "Batte de baseball", prix=1015, category = "Armes blanches", imagename = "Batte_de_baseball", imagepath = "Armes_blanches", weapname = "weapon_bat"},
 --   {name = "Bouteille cassée", category = "Armes blanches", imagename = "Bouteille_cassee", imagepath = "Armes_blanches", weapname = "weapon_bottle"},
    {name = "Clé anglaise", prix=945, category = "Armes blanches", imagename = "Cle_anglaise", imagepath = "Armes_blanches", weapname = "weapon_wrench"},
    {name = "Club de golf", prix=1015, category = "Armes blanches", imagename = "Club_de_golf", imagepath = "Armes_blanches", weapname = "weapon_golfclub"},
    {name = "Couteau", prix=1225, category = "Armes blanches", imagename = "Couteau", imagepath = "Armes_blanches", weapname = "weapon_knife"},
    {name = "Pied de biche", prix=1015, category = "Armes blanches", imagename = "Pied_de_biche", imagepath = "Armes_blanches", weapname = "weapon_crowbar"},
    {name = "Pelle", prix=945, category = "Armes blanches", imagename = "Pelle", imagepath = "Armes_blanches", weapname = "weapon_pelle"},
    {name = "Pioche", prix=945, category = "Armes blanches", imagename = "Pioche", imagepath = "Armes_blanches", weapname = "weapon_pickaxe"},
    {name = "Poing americain", prix=2450, category = "Armes blanches", imagename = "Poing_americain", imagepath = "Armes_blanches", weapname = "weapon_knuckle"},
   -- {name = "Canette", category = "Armes blanches", imagename = "Canette", imagepath = "Armes_blanches", weapname = "weapon_canette"},
--    {name = "Bouteille", category = "Armes blanches", imagename = "Bouteille", imagepath = "Armes_blanches", weapname = "weapon_bouteille"},
    {name = "Queue de billard", prix=1015, category = "Armes blanches", imagename = "Queue_de_billard", imagepath = "Armes_blanches", weapname = "weapon_poolcue"},


    {name = "Carabine", prix=35000, category = "Armes lourdes", imagename = "Carabine", imagepath = "Armes_lourdes", weapname = "weapon_carbinerifle"},
    {name = "Carabine speciale", prix=42000, category = "Armes lourdes", imagename = "Carabine_speciale", imagepath = "Armes_lourdes", weapname = "weapon_specialcarbine"},
    {name = "Fusil à pompe", prix=21000, category = "Armes lourdes", imagename = "Fusil_a_pompe", imagepath = "Armes_lourdes", weapname = "weapon_pumpshotgun"},
    {name = "Mitraillette", prix=28000, category = "Armes lourdes", imagename = "Mitraillette", imagepath = "Armes_lourdes", weapname = "weapon_smg"},
    {name = "Mousquet", prix=8750, category = "Armes lourdes", imagename = "Mousquet", imagepath = "Armes_lourdes", weapname = "weapon_musket"},


    {name = "Beanbag", prix=3500, category = "Utilitaire", imagename = "Beanbag", imagepath = "Autres", weapname = "weapon_beambag"},
    {name = "Pistol Magazine Box", prix=385, category = "Utilitaire", imagename = "ammobox_pistol", imagepath = "Autres", weapname = "ammobox_pistol"},
    {name = "Sub Magazine Box", prix=560, category = "Utilitaire", imagename = "ammobox_sub", imagepath = "Autres", weapname = "ammobox_sub"},
    {name = "Shotgun Magazine Box", prix=700, category = "Utilitaire", imagename = "ammobox_shotgun", imagepath = "Autres", weapname = "ammobox_shotgun"},
    {name = "Rifle Magazine Box", prix=770, category = "Utilitaire", imagename = "ammobox_rifle", imagepath = "Autres", weapname = "ammobox_rifle"},
    {name = "Sniper Magazine Box", prix=875, category = "Utilitaire", imagename = "ammobox_snip", imagepath = "Autres", weapname = "ammobox_snip"},
    {name = "Heavy Magazine Box", prix=875, category = "Utilitaire", imagename = "ammobox_heavy", imagepath = "Autres", weapname = "ammobox_heavy"},
    {name = "Beambag Magazine Box", prix=665, category = "Utilitaire", imagename = "ammobox_beambag", imagepath = "Autres", weapname = "ammobox_beambag"},
    {name = "Flaregun Ammo Box", prix=505, category = "Utilitaire", imagename = "ammobox_flare", imagepath = "Autres", weapname = "ammobox_flare"},

    {name = "Poignée d'arme", prix=3150, category = "Utilitaire", imagename = "components_grip", imagepath = "Autres", weapname = "components_grip"},
    {name = "Silencieux", prix=10500, category = "Utilitaire", imagename = "components_suppressor", imagepath = "Autres", weapname = "components_suppressor"},
    {name = "Lampe torche", prix=4550, category = "Utilitaire", imagename = "components_flashlight", imagepath = "Autres", weapname = "components_flashlight"},

    {name = "Fusée de détresse", prix=504, category = "Utilitaire", imagename = "weapon_flare", imagepath = "Autres", weapname = "weapon_flare"},

    {name = "Tazer", prix=700, category = "Utilitaire", imagename = "Tazer", imagepath = "Autres", weapname = "weapon_stungun_mp"},
   -- {name = "Gas lacrymogène", prix=700, category = "Utilitaire", imagename = "weapon_bzgas", imagepath = "Autres", weapname = "weapon_bzgas"},
    {name = "Extincteur", prix=5250, category = "Utilitaire", imagename = "weapon_fireextinguisher", imagepath = "Autres", weapname = "weapon_fireextinguisher"},
    {name = "Lampe", prix=700, category = "Utilitaire", imagename = "weapon_flashlight", imagepath = "Autres", weapname = "weapon_flashlight"},
   -- {name = "Grenade fumigène", prix=700, category = "Utilitaire", imagename = "weapon_smokelspd", imagepath = "Autres", weapname = "weapon_smokelspd"},
    {name = "Matraque", prix=700, category = "Utilitaire", imagename = "Matraque", imagepath = "Autres", weapname = "weapon_nightstick"},
    {name = "Pistolet de détresse", prix=4550, category = "Utilitaire", imagename = "pistolet_de_detresse", imagepath = "Autres", weapname = "weapon_flaregun"},
    {name = "Herse", prix=700, category = "Utilitaire", imagename = "herse", imagepath = "Autres", weapname = "herse"},
    {name = "Marteau", prix=1015, category = "Utilitaire", imagename = "marteau", imagepath = "Autres", weapname = "weapon_hammer"},


    {name = "Colt M45A1", prix=23975, category = "Pistolets", imagename = "colt_911", imagepath = "Pistolet", weapname = "weapon_heavypistol"},
    {name = "Petoire", prix=11900, category = "Pistolets", imagename = "Petoire", imagepath = "Pistolet", weapname = "weapon_snspistol"},
    {name = "Pistolet", prix=19250, category = "Pistolets", imagename = "Pistolet", imagepath = "Pistolet", weapname = "weapon_pistol"},
    {name = "Pistolet de combat", prix=2450, category = "Pistolets", imagename = "Pistolet_de_combat", imagepath = "Pistolet", weapname = "weapon_combatpistol"},
    {name = "Revolver", prix=29155, category = "Pistolets", imagename = "Revolver", imagepath = "Pistolet", weapname = "weapon_revolver"},
    {name = "Pistolet Vintage", prix=14105, category = "Pistolets", imagename = "Vintage_Pistol", imagepath = "Pistolet", weapname = "weapon_vintagepistol"},
}

function OpenAmmunationUI()
    -- DataSendAmmu.catalogue = ammunation["weapons"].nibard
    DataSendAmmu.catalogue = {}
    if p:getJob() == "ammunation" then 
        for k,v in pairs(allweapons) do
            table.insert(DataSendAmmu.catalogue, {id = k, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Ammunation/"..v.imagepath.."/"..v.imagename..".webp", 
            category=v.category, price = v.prix, itemname = v.weapname, label = v.name, ownCallbackName= 'Menu_Ammu_preview_callback'})
        end
        DataSendAmmu.disableSubmit = false
    else
        for k,v in pairs(allweapons) do
            table.insert(DataSendAmmu.catalogue, {id = k, image="https://assets-vision-fa.cdn.purplemaze.net/assets/Ammunation/"..v.imagepath.."/"..v.imagename..".webp", 
            category=v.category, price = v.prix, itemname = v.weapname, label = v.name, ownCallbackName= 'Menu_Ammu_preview_callback'})
        end
        DataSendAmmu.disableSubmit = true
    end

    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
    Wait(50)
    AmmuShop.open = true
    SendNUIMessage({
        type = "openWebview",
        name = "MenuGrosCatalogue",
        data = DataSendAmmu
    })
    forceHideRadar()
    SetNuiFocusKeepInput(true)
    CreateThread(function()
        local disablekeys = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 23, 24, 25, 26, 32, 33, 34, 35, 37, 44, 45, 61, 268,270, 269,266,281,280,278,279,71,72,73,74,77,87,232,62, 63,69, 70, 140, 141, 142, 257, 263, 264}
        while AmmuShop.open do 
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


for k, v in pairs(zoneAmmunation) do
    CreateThread(function()
        while zone == nil do Wait(1) end

        zone.addZone(
            "Armurerie"..math.random(1, 9999999), -- Nom
            v.position,-- Position
            "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir l'armurerie",  -- Text afficher
            function() -- Action qui seras fait
                if not AmmuShop.open then
                    OpenAmmunationUI() -- Ouvrir le menu
                end
            end,
            true, -- Avoir un marker ou non
            29, -- Id / type du marker
            0.4, -- La taille
            {50, 168, 82}, -- RGB
            170 -- Alpha
        )
        --AddBlip(v.blip,110,2,0.4, 5,'Armurie')
    end)
end

for k, v in pairs(zoneAmmunationNord) do
    CreateThread(function()
        while zone == nil do Wait(1) end

        zone.addZone(
            "Armurerie"..math.random(1, 9999999), -- Nom
            v.position,-- Position
            "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir l'armurerie",  -- Text afficher
            function() -- Action qui seras fait
                if not AmmuShop.open then
                    OpenAmmunationUI() -- Ouvrir le menu
                end
            end,
            true, -- Avoir un marker ou non
            29, -- Id / type du marker
            0.4, -- La taille
            {50, 168, 82}, -- RGB
            170 -- Alpha
        )
        --AddBlip(v.blip,110,2,0.4, 5,'Armurie')
    end)
end