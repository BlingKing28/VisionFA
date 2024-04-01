local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)


local helicoptere = {
    {
        id=0,
        image="./assets/LSPD/img2.png",
        name="helicoptere",
        categorie="helicoptere"
    },
    {
        id=1,
        image="./assets/LSPD/img2.png",
        name="helicoptere",
        categorie="helicoptere"
    },
    {
        id=2,
        image="./assets/LSPD/img2.png",
        name="helicoptere",
        categorie="helicoptere"
    },
    {
        id=3,
        image="./assets/LSPD/img2.png",
        name="helicoptere",
        categorie="helicoptere"
    },
    {
        id=4,
        image="./assets/LSPD/img2.png",
        name="helicoptere",
        categorie="helicoptere"
    },
    {
        id=5,
        image="./assets/LSPD/img2.png",
        name="helicoptere",
        categorie="helicoptere"
    },
    {
        id=6,
        image="./assets/LSPD/img2.png",
        name="helicoptere",
        categorie="helicoptere"
    },
    {
        id=7,
        image="./assets/LSPD/img2.png",
        name="helicoptere",
        categorie="helicoptere"
    },
    {
        id=8,
        image="./assets/LSPD/img2.png",
        name="helicoptere",
        categorie="helicoptere"
    },
    {
        id=9,
        image="./assets/LSPD/img2.png",
        name="helicoptere",
        categorie="helicoptere"
    },
}


RegisterCommand("lspdhelicoptere", function(source, args, rawCommand)   
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'Menu_LSPD_helicoptere',
        data = helicoptere
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