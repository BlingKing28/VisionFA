local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)


local bateaux = {
    {
        id=0,
        image="./assets/LSPD/img1.png",
        name="bateau",
        categorie="bateaux"
    },
    {
        id=1,
        image="./assets/LSPD/img1.png",
        name="bateau",
        categorie="bateaux"
    },
    {
        id=2,
        image="./assets/LSPD/img1.png",
        name="bateau",
        categorie="bateaux"
    },
    {
        id=3,
        image="./assets/LSPD/img1.png",
        name="bateau",
        categorie="bateaux"
    },
    {
        id=4,
        image="./assets/LSPD/img1.png",
        name="bateau",
        categorie="bateaux"
    },
    {
        id=5,
        image="./assets/LSPD/img1.png",
        name="bateau",
        categorie="bateaux"
    },
    {
        id=6,
        image="./assets/LSPD/img1.png",
        name="bateau",
        categorie="bateaux"
    },
    {
        id=7,
        image="./assets/LSPD/img1.png",
        name="bateau",
        categorie="bateaux"
    },
    {
        id=8,
        image="./assets/LSPD/img1.png",
        name="bateau",
        categorie="bateaux"
    },
    {
        id=9,
        image="./assets/LSPD/img1.png",
        name="bateau",
        categorie="bateaux"
    },
}


RegisterCommand("lspdbateaux", function(source, args, rawCommand)   
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'Menu_LSPD_bateaux',
        data = bateaux
    }));
end, false)


RegisterNUICallback("valider_achatrapide_bike", function(data, cb)
    print(data.choiceUser.id,data.choiceUser.prix)
    if p:pay(data.choiceUser.prix) then
        data.choiceUser.name = "saumon"
        TriggerSecurGiveEvent("core:addItemToInventory", token, data.choiceUser.name, 1, {})
        -- ShowNotification("Vous venez d'acheter un(e) "..data.choiceUser.name)

        -- New notif
        exports['vNotif']:createNotification({
            type = 'DOLLAR',
            duration = 5, -- In seconds, default:  4

            content = "Vous venez d'acheter ~s un(e) "..data.choiceUser.name
        })

    end
end)

RegisterNUICallback("focusOut", function (data, cb)
    TriggerScreenblurFadeOut(0.5)
    openRadarProperly()

end)