local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)


RegisterNUICallback("progressMenuLST", function(data)
        local gradeTenue = nil
        local typeTenue = nil 
        local tenue = nil
        if data.sousCategory == "Tenues" then
            gradeTenue = data.TenueGrade
            typeTenue = data.label
            if p:isMale() then
                tenue = listGradeM_LST[gradeTenue].tenues[typeTenue]
            else
                tenue = listGradeF_LST[gradeTenue].tenues[typeTenue]
            end
            TriggerEvent('skinchanger:change', "shoes_1", tenue.chaussures)
            TriggerEvent('skinchanger:change', "shoes_2", tenue.varChaussures)

            TriggerEvent('skinchanger:change', "bags_1", tenue.sac)
            TriggerEvent('skinchanger:change', "bags_2", tenue.varSac)

            TriggerEvent('skinchanger:change', "decals_1", tenue.decals)
            TriggerEvent('skinchanger:change', "decals_2", tenue.varDecals)

            TriggerEvent('skinchanger:change', "pants_1", tenue.pantalon)
            TriggerEvent('skinchanger:change', "pants_2", tenue.varPantalon)

            TriggerEvent('skinchanger:change', "chain_1", tenue.chaine)
            TriggerEvent('skinchanger:change', "chain_2", tenue.varChaine)
        
            TriggerEvent('skinchanger:change', "torso_1", tenue.haut)
            TriggerEvent('skinchanger:change', "torso_2", tenue.varHaut)

            TriggerEvent('skinchanger:change', "tshirt_1", tenue.sousHaut)
            TriggerEvent('skinchanger:change', "tshirt_2", tenue.varSousHaut)

            TriggerEvent('skinchanger:change', "mask_1", tenue.mask)
            TriggerEvent('skinchanger:change', "mask_2", tenue.varMask)

            TriggerEvent('skinchanger:change', "helmet_1", tenue.helmet)
            TriggerEvent('skinchanger:change', "helmet_2", tenue.varHelmet)

            TriggerEvent('skinchanger:change', "glasses_1", tenue.glasses)
            TriggerEvent('skinchanger:change', "glasses_2", tenue.varGlasses)
        
            if tenue.gpb ~= 0 then
                TriggerEvent('skinchanger:change', "bproof_1", tenue.gpb)
                TriggerEvent('skinchanger:change', "bproof_2", tenue.varGpb)
            else
                TriggerEvent('skinchanger:change', "bproof_1", 0)
                TriggerEvent('skinchanger:change', "bproof_2", 0)
            end

            TriggerEvent('skinchanger:change', "arms", tenue.bras)
            TriggerEvent('skinchanger:change', "arms_2", tenue.varBras)
        end
        if data.name then
            local skin = SkinChangerGetSkin()
            local tenue = {
                ['tshirt_1'] = skin["tshirt_1"],
                ['tshirt_2'] = skin["tshirt_2"],
                ['torso_1'] = skin["torso_1"],
                ['torso_2'] = skin["torso_2"],
                ['decals_1'] = skin["decals_1"],
                ['decals_2'] = skin["decals_2"],
                ['arms'] = skin["arms"],
                ['arms_2'] = skin["arms_2"],
                ['pants_1'] = skin["pants_1"],
                ['pants_2'] = skin["pants_2"],
                ['shoes_1'] = skin["shoes_1"],
                ['shoes_2'] = skin["shoes_2"],
                ['bags_1'] = skin['bags_1'],
                ['bags_2'] = skin['bags_2'],
                ['chain_1'] = skin['chain_1'],
                ['chain_2'] = skin['chain_2'],
                ['helmet_1'] = skin['helmet_1'],
                ['helmet_2'] = skin['helmet_2'],
                ['ears_1'] = skin['ears_1'],
                ['ears_2'] = skin['ears_2'],
                ['mask_1'] = skin['mask_1'],
                ['mask_2'] = skin['mask_2'],
                ['glasses_1'] = skin['glasses_1'],
                ['glasses_2'] = skin['glasses_2'],
                ['bproof_1'] = skin['bproof_1'],
                ['bproof_2'] = skin['bproof_2'],
            }
            exports['vNotif']:createNotification({
                type = 'JAUNE',
                content = "Vous venez de récupérer votre tenue ~s "..data.name
            })
            TriggerSecurGiveEvent("core:addItemToInventory", token, "outfit", 1, {renamed = data.name, data = tenue})
            closeUI()
        end
end)

function LSTVestiaireDev()
    local dataVestiaireLST = {}
    dataVestiaireLST = {
        catalogue= {},
        headerIcon= 'assets/icons/market-cart.png',
        headerIconName= 'Vestiaire',
        callbackName= 'progressMenuLST',
        progressBar= {
            {
                name= 'Grades'
            }, 
            {
                name= 'Tenues'
           }
        },
        headerImage= 'https://assets-vision-fa.cdn.purplemaze.net/assets/Headers/header_lst.webp'
    }

    if p:isMale() then
        listGradeM_LST = {
            ["LST - ML"] = {
                id = 1,
                tenues = {
                    ["Gris"] = { 
                        id = 1,
                        haut= 519, varHaut = 11, 
                        sousHaut = 263, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 109, varChaussures = 1, 
                        sac = 166, varSac = 0, 
                        gpb = 109, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 0, varMask = 0,
                        decals = 180, varDecals = 0,
                        helmet = -1, varHelmet = 0,
                    },
                    ["Blanc"] = {
                        id = 2,
                        haut= 519, varHaut = 12, 
                        sousHaut = 263, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 109, varChaussures = 1, 
                        sac = 166, varSac = 0, 
                        gpb = 109, varGpb = 0, 
                        pantalon = 202, varPantalon = 2,
                        mask = 0, varMask = 0,
                        decals = 0, varDecals = 0,
                        helmet = -1, varHelmet = 0,
                    },
                    ["Bleu"] = {
                        id = 3,
                        haut= 519, varHaut = 10, 
                        sousHaut = 263, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 109, varChaussures = 1, 
                        sac = 166, varSac = 0, 
                        gpb = 109, varGpb = 0, 
                        pantalon = 202, varPantalon = 2,
                        mask = 0, varMask = 0,
                        decals = 0, varDecals = 0,
                        helmet = -1, varHelmet = 0,
                    },
                },
            },

            ["LST - MC"] = {
                id = 2,
                tenues = {
                    ["Gris"] = { 
                        id = 1,
                        haut= 518, varHaut = 12, 
                        sousHaut = 263, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 11, varBras = 0,
                        chaussures = 109, varChaussures = 1, 
                        sac = 166, varSac = 0, 
                        gpb = 109, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 0, varMask = 0,
                        decals = 180, varDecals = 0,
                        helmet = -1, varHelmet = 0,
                    },
                    ["Blanc"] = {
                        id = 2,
                        haut= 518, varHaut = 11, 
                        sousHaut = 263, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 11, varBras = 0,
                        chaussures = 109, varChaussures = 1, 
                        sac = 166, varSac = 0, 
                        gpb = 109, varGpb = 0, 
                        pantalon = 202, varPantalon = 2,
                        mask = 0, varMask = 0,
                        decals = 0, varDecals = 0,
                        helmet = -1, varHelmet = 0,
                    },
                    ["Bleu"] = {
                        id = 3,
                        haut= 518, varHaut = 10, 
                        sousHaut = 263, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 11, varBras = 0,
                        chaussures = 109, varChaussures = 1, 
                        sac = 166, varSac = 0, 
                        gpb = 109, varGpb = 0, 
                        pantalon = 202, varPantalon = 2,
                        mask = 0, varMask = 0,
                        decals = 0, varDecals = 0,
                        helmet = -1, varHelmet = 0,
                    },
                },
            },

        }
            for k,v in pairs(listGradeM_LST) do
            table.insert(dataVestiaireLST.catalogue, {
                    id= v.id,
                    label = k,
                    image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Vestiaire/LST/Grades/"..v.id..".webp",
                    category= "Grades",
                    subCategory = "Grades",
                    idVariation= v.id,
            })
            for i,j in pairs(v.tenues) do
                if j.id ~= nil then
                    table.insert(dataVestiaireLST.catalogue, {
                        id= j.id,
                        label = i,
                        --image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Vestiaire/LST/Tenues/Homme/"..v.id.."/"..j.id..".webp",
                        "https://assets-vision-fa.cdn.purplemaze.net/assets/Vestiaire/LST/Tenues/Homme/"..v.id.."/"..j.id..".webp",
                        category= "Tenues",
                        sousCategory= "Tenues",
                        idVariation= j.id,
                        targetId = v.id,
                        TenueGrade = k,
                    })
                end
            end
        end
    else
        listGradeF_LST = {
            ["LST - ML"] = {
                id = 1,
                tenues = {
                    ["Gris"] = { 
                        id = 1,
                        haut= 563, varHaut = 11, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 159, varChaussures = 1, 
                        sac = 161, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 219, varPantalon = 0,
                        mask = 0, varMask = 0,
                        decals = 193, varDecals = 0,
                        helmet = -1, varHelmet = 0,
                    },
                    ["Blanc"] = {
                        id = 2,
                        haut= 563, varHaut = 12, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 159, varChaussures = 1, 
                        sac = 161, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 196, varPantalon = 1,
                        mask = 0, varMask = 0,
                        decals = 0, varDecals = 0,
                        helmet = -1, varHelmet = 0,
                    },
                    ["Bleu"] = {
                        id = 3,
                        haut= 563, varHaut = 10, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 159, varChaussures = 1, 
                        sac = 161, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 196, varPantalon = 1,
                        mask = 0, varMask = 0,
                        decals = 0, varDecals = 0,
                        helmet = -1, varHelmet = 0,
                    },
                },
            },

            ["LST - MC"] = {
                id = 2,
                tenues = {
                    ["Gris"] = { 
                        id = 1,
                        haut= 562, varHaut = 12, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 9, varBras = 0,
                        chaussures = 159, varChaussures = 1, 
                        sac = 161, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 219, varPantalon = 0,
                        mask = 0, varMask = 0,
                        decals = 193, varDecals = 0,
                        helmet = -1, varHelmet = 0,
                    },
                    ["Blanc"] = {
                        id = 2,
                        haut= 562, varHaut = 11, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 9, varBras = 0,
                        chaussures = 159, varChaussures = 1, 
                        sac = 161, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 219, varPantalon = 0,
                        mask = 0, varMask = 0,
                        decals = 193, varDecals = 0,
                        helmet = -1, varHelmet = 0,
                    },
                    ["Bleu"] = {
                        id = 3,
                        haut= 562, varHaut = 10, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 9, varBras = 0,
                        chaussures = 159, varChaussures = 1, 
                        sac = 161, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 196, varPantalon = 1,
                        mask = 0, varMask = 0,
                        decals = 193, varDecals = 0,
                        helmet = -1, varHelmet = 0,
                    },
                },
            },

        }
        for k,v in pairs(listGradeF_LST) do
            table.insert(dataVestiaireLST.catalogue, {
                    id= v.id,
                    label = k,
                    image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Vestiaire/LST/Grades/"..v.id..".webp",
                    category= "Grades",
                    subCategory = "Grades",
                    idVariation= v.id,
            })
            for i,j in pairs(v.tenues) do
                if j.id ~= nil then
                    table.insert(dataVestiaireLST.catalogue, {
                        id= j.id,
                        label = i,
                        image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Vestiaire/LST/Tenues/Femme/"..v.id.."/"..j.id..".webp",
                        category= "Tenues",
                        sousCategory= "Tenues",
                        idVariation= j.id,
                        targetId = v.id,
                        TenueGrade = k,
                    })
                end
            end
        end
    end

    Wait(500)
    SendNuiMessage(json.encode({
        type = 'openWebview',
        name = 'MenuProgress',
        data = dataVestiaireLST
    }))
end
