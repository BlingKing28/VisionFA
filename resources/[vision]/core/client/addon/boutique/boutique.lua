local Boutique = {
    {
        id = 1,
        category = 2,
        name = 'ROLEX',
        subName = 'Montre de luxe',
        availableColors = {
            { value = '#AFFFFF', image = 'assets/Boutique/placeholder.png' },
            { value = '#BA0293', image = 'assets/Boutique/placeholder.png' }
        },
        price = 3000,
        customFields = {'ECRITURE', 'NUMERO'},
        owned = false,
    },
    {
        id = 2,
        category = 2,
        name = 'ROLEX2',
        subName = 'Montre de luxe',
        availableColors = {
            { value = '#AFFFFF', image = 'assets/Boutique/placeholder.png' },
            { value = '#BA0293', image = 'assets/Boutique/placeholder.png' }
        },
        price = 3000,
        customFields = {'ECRITURE', 'NUMERO'},
        owned = false,
    },
}

RegisterCommand("openBoutique", function(source, args)
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = args[1],
      --  data = Boutique
    }))
end)