local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

RegisterNUICallback("progressMenuSAMS", function(data)
    local gradeTenue = nil
    local typeTenue = nil 
    local tenue = nil
        if data.sousCategory == "Tenues" then
        gradeTenue = data.TenueGrade
        typeTenue = data.label
        if p:isMale() then
            tenue = listGradeM_SAMS[gradeTenue].tenues[typeTenue]
        else
            tenue = listGradeF_SAMS[gradeTenue].tenues[typeTenue]
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


function LoadSAMSVestiaire()
    dataVestiaireSAMS = {}
        dataVestiaireSAMS = {
            catalogue= {},
            headerIcon= 'assets/icons/market-cart.png',
            headerIconName= 'Vestiaire',
            callbackName= 'progressMenuSAMS',
            progressBar= {
                {
                    name= 'Grades'
                }, 
                {
                    name= 'Tenues'
            }
            },
            headerImage= 'assets/headers/header_sams.jpg'
        }

    if p:isMale() then
        listGradeM_SAMS = {
            ["Interne"] = {
                id = 1,
                tenues = {
                    ["Classe-A"] = { 
                        id = 1,
                        haut= 520, varHaut = 6, 
                        sousHaut = 221, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 189, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Classe-B"] = {
                        id = 2,
                        haut= 519, varHaut = 6, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Classe-C"] = {
                        id = 3,
                        haut= 518, varHaut = 6, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 92, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Chirurgie"] = {
                        id = 4,
                        haut= 508, varHaut = 6, 
                        sousHaut = 15, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 92, varBras = 1,
                        chaussures = 113, varChaussures = 17, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 185, varPantalon = 6,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                }
            },
            ["Junior Doctor"] = {
                id = 2,
                tenues = {
                    ["Classe-A"] = { 
                        id = 1,
                        haut= 520, varHaut = 6, 
                        sousHaut = 221, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 189, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 180, varDecals = 0
                    },
                    ["Classe-B"] = {
                        id = 2,
                        haut= 519, varHaut = 6, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 180, varDecals = 0
                    },
                    ["Classe-C"] = {
                        id = 3,
                        haut= 518, varHaut = 6, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 92, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 180, varDecals = 0
                    },
                    ["PullOver"] = {
                        id = 4,
                        haut= 534, varHaut = 7, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Chirurgie"] = {
                        id = 5,
                        haut= 508, varHaut = 1, 
                        sousHaut = 15, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 92, varBras = 1,
                        chaussures = 113, varChaussures = 12, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 185, varPantalon = 1,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                }
            },
            ["Doctor"] = {
                id = 3,
                tenues = {
                    ["Classe-A"] = { 
                        id = 1,
                        haut= 520, varHaut = 6, 
                        sousHaut = 221, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 189, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 181, varDecals = 0
                    },
                    ["Classe-B"] = {
                        id = 2,
                        haut= 519, varHaut = 6, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 181, varDecals = 0
                    },
                    ["Classe-C"] = {
                        id = 3,
                        haut= 518, varHaut = 6, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 92, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 181, varDecals = 0
                    },
                    ["PullOver"] = {
                        id = 4,
                        haut= 534, varHaut = 7, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Chirurgie"] = {
                        id = 5,
                        haut= 508, varHaut = 3, 
                        sousHaut = 15, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 92, varBras = 1,
                        chaussures = 113, varChaussures = 18, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 185, varPantalon = 5,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                }
            },
            ["Senior Doctor"] = {
                id = 4,
                tenues = {
                    ["Classe-A"] = { 
                        id = 1,
                        haut= 520, varHaut = 6, 
                        sousHaut = 221, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 189, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 182, varDecals = 0
                    },
                    ["Classe-B"] = {
                        id = 2,
                        haut= 519, varHaut = 6, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 182, varDecals = 0
                    },
                    ["Classe-C"] = {
                        id = 3,
                        haut= 518, varHaut = 6, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 92, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 182, varDecals = 0
                    },
                    ["PullOver"] = {
                        id = 4,
                        haut= 534, varHaut = 7, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Chirurgie"] = {
                        id = 5,
                        haut= 508, varHaut = 7, 
                        sousHaut = 15, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 92, varBras = 1,
                        chaussures = 113, varChaussures = 3, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 185, varPantalon = 3,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                }
            }, 
            ["Supervisor"] = {
                id = 5,
                tenues = {
                    ["Classe-A"] = { 
                        id = 1,
                        haut= 520, varHaut = 6, 
                        sousHaut = 221, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 189, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 173, varDecals = 0
                    },
                    ["Classe-B"] = {
                        id = 2,
                        haut= 519, varHaut = 6, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 173, varDecals = 0
                    },
                    ["Classe-C"] = {
                        id = 3,
                        haut= 518, varHaut = 6, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 92, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 173, varDecals = 0
                    },
                    ["PullOver"] = {
                        id = 4,
                        haut= 534, varHaut = 7, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Veste"] = {
                        id = 5,
                        haut= 535, varHaut = 5, 
                        sousHaut = 221, varSousHaut = 0, 
                        chaine = 211, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 98, varGpb = 1, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Chirurgie"] = {
                        id = 6,
                        haut= 508, varHaut = 2, 
                        sousHaut = 15, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 92, varBras = 1,
                        chaussures = 113, varChaussures = 16, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 185, varPantalon = 2,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                },
            },
            ["Direction"] = {
                id = 6,
                tenues = {
                    ["Classe-A"] = { 
                        id = 1,
                        haut= 520, varHaut = 6, 
                        sousHaut = 221, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 189, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 179, varDecals = 0
                    },
                    ["Classe-B"] = {
                        id = 2,
                        haut= 519, varHaut = 6, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 179, varDecals = 0
                    },
                    ["Classe-C"] = {
                        id = 3,
                        haut= 518, varHaut = 6, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 92, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 173, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 179, varDecals = 0
                    },
                    ["PullOver"] = {
                        id = 4,
                        haut= 534, varHaut = 7, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 0, varSac = 0,
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Veste"] = {
                        id = 5,
                        haut= 535, varHaut = 5, 
                        sousHaut = 221, varSousHaut = 0, 
                        chaine = 211, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 98, varGpb = 1, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Chirurgie"] = {
                        id = 6,
                        haut= 508, varHaut = 4, 
                        sousHaut = 15, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 92, varBras = 1,
                        chaussures = 113, varChaussures = 6, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 185, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                },
            },
            ["TEMS"] = {
                id = 7,
                tenues = {
                    ["Duty"] = { 
                        id = 1,
                        haut= 448, varHaut = 0, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Operation"] = { 
                        id = 2,
                        haut= 522, varHaut = 2, 
                        sousHaut = 289, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 61, varChaussures = 0, 
                        sac = 205, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 206, varPantalon = 4,
                        helmet = 213, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                },
            },
            ["Divers"] = {
                id = 8,
                tenues = {
                    ["Bike"] = { 
                        id = 1,
                        haut= 540, varHaut = 3, 
                        sousHaut = 222, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 0, varBras = 0,
                        chaussures = 126, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 12, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Boat"] = { 
                        id = 2,
                        haut= 513, varHaut = 2, 
                        sousHaut = 222, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 0, varBras = 0,
                        chaussures = 16, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 181, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                },
            },
            ["Coroner"] = {
                id = 9,
                tenues = {
                    ["Classe-B"] = { 
                        id = 1,
                        haut= 531, varHaut = 8, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 86, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Classe-C"] = { 
                        id = 2,
                        haut= 530, varHaut = 8, 
                        sousHaut = 204, varSousHaut = 0, 
                        chaine = 208, varChaine = 0, 
                        bras = 92, varBras = 1,
                        chaussures = 103, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 191, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                }
            },  
        }             
        for k,v in pairs(listGradeM_SAMS) do
            table.insert(dataVestiaireSAMS.catalogue, {
                    id= v.id,
                    label = k,
                    image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Vestiaire/SAMS/Grades/SAMS.webp",
                    category= "Grades",
                    subCategory = "Grades",
                    idVariation= v.id,
            })
            for i,j in pairs(v.tenues) do
                if j.id ~= nil then
                    table.insert(dataVestiaireSAMS.catalogue, {
                        id= j.id,
                        label = i,
                        image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Vestiaire/SAMS/Tenues/Homme/"..v.id.."/"..j.id..".webp",
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
        listGradeF_SAMS = {
            ["Interne"] = {
                id = 1,
                tenues = {
                    ["Classe-A"] = { 
                        id = 1,
                        haut= 564, varHaut = 6, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 0, varBras = 0,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 194, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Classe-B"] = {
                        id = 2,
                        haut= 563, varHaut = 6, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Classe-C"] = {
                        id = 3,
                        haut= 562, varHaut = 6, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 106, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Chirurgie"] = {
                        id = 4,
                        haut= 552, varHaut = 6, 
                        sousHaut = 14, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 106, varBras = 1,
                        chaussures = 117, varChaussures = 17, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 190, varPantalon = 6,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                }
            },
            ["Junior Doctor"] = {
                id = 2,
                tenues = {
                    ["Classe-A"] = { 
                        id = 1,
                        haut= 564, varHaut = 6, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 0, varBras = 0,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 194, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 193, varDecals = 0
                    },
                    ["Classe-B"] = {
                        id = 2,
                        haut= 563, varHaut = 6, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 193, varDecals = 0
                    },
                    ["Classe-C"] = {
                        id = 3,
                        haut= 562, varHaut = 6, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 106, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 193, varDecals = 0
                    },
                    ["PullOver"] = {
                        id = 4,
                        haut= 565, varHaut = 7, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Chirurgie"] = {
                        id = 5,
                        haut= 552, varHaut = 2, 
                        sousHaut = 14, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 106, varBras = 1,
                        chaussures = 117, varChaussures = 12, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 190, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                }
            },
            ["Doctor"] = {
                id = 3,
                tenues = {
                    ["Classe-A"] = { 
                        id = 1,
                        haut= 564, varHaut = 6, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 0, varBras = 0,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 194, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 194, varDecals = 0
                    },
                    ["Classe-B"] = {
                        id = 2,
                        haut= 563, varHaut = 6, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 194, varDecals = 0
                    },
                    ["Classe-C"] = {
                        id = 3,
                        haut= 562, varHaut = 6, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 106, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 194, varDecals = 0
                    },
                    ["PullOver"] = {
                        id = 4,
                        haut= 565, varHaut = 7, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Chirurgie"] = {
                        id = 5,
                        haut= 552, varHaut = 3, 
                        sousHaut = 14, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 106, varBras = 1,
                        chaussures = 117, varChaussures = 18, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 190, varPantalon = 3,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                }
            },
            ["Senior Doctor"] = {
                id = 4,
                tenues = {
                    ["Classe-A"] = { 
                        id = 1,
                        haut= 564, varHaut = 6, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 0, varBras = 0,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 194, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 195, varDecals = 0
                    },
                    ["Classe-B"] = {
                        id = 2,
                        haut= 563, varHaut = 6, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 195, varDecals = 0
                    },
                    ["Classe-C"] = {
                        id = 3,
                        haut= 562, varHaut = 6, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 106, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 195, varDecals = 0
                    },
                    ["PullOver"] = {
                        id = 4,
                        haut= 565, varHaut = 7, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Chirurgie"] = {
                        id = 5,
                        haut= 552, varHaut = 2, 
                        sousHaut = 14, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 106, varBras = 1,
                        chaussures = 117, varChaussures = 16, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 190, varPantalon = 1,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                }
            }, 
            ["Supervisor"] = {
                id = 5,
                tenues = {
                    ["Classe-A"] = { 
                        id = 1,
                        haut= 564, varHaut = 6, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 0, varBras = 0,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 194, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 186, varDecals = 0
                    },
                    ["Classe-B"] = {
                        id = 2,
                        haut= 563, varHaut = 6, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 186, varDecals = 0
                    },
                    ["Classe-C"] = {
                        id = 3,
                        haut= 562, varHaut = 6, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 106, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 186, varDecals = 0
                    },
                    ["PullOver"] = {
                        id = 4,
                        haut= 565, varHaut = 7, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Veste"] = {
                        id = 5,
                        haut= 576, varHaut = 5, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 98, varGpb = 1, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Chirurgie"] = {
                        id = 6,
                        haut= 552, varHaut = 0, 
                        sousHaut = 14, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 106, varBras = 1,
                        chaussures = 117, varChaussures = 3, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 190, varPantalon = 5,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                },
            },
            ["Direction"] = {
                id = 6,
                tenues = {
                    ["Classe-A"] = { 
                        id = 1,
                        haut= 564, varHaut = 6, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 0, varBras = 0,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 194, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 192, varDecals = 0
                    },
                    ["Classe-B"] = {
                        id = 2,
                        haut= 563, varHaut = 6, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 192, varDecals = 0
                    },
                    ["Classe-C"] = {
                        id = 3,
                        haut= 562, varHaut = 6, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 106, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 169, varSac = 1, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 192, varDecals = 0
                    },
                    ["PullOver"] = {
                        id = 4,
                        haut= 565, varHaut = 7, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Veste"] = {
                        id = 5,
                        haut= 576, varHaut = 5, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 6, 
                        sac = 0, varSac = 0, 
                        gpb = 98, varGpb = 1, 
                        pantalon = 195, varPantalon = 4,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Chirurgie"] = {
                        id = 6,
                        haut= 552, varHaut = 4, 
                        sousHaut = 14, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 106, varBras = 1,
                        chaussures = 117, varChaussures = 17, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 190, varPantalon = 6,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                },
            },
            ["TEMS"] = {
                id = 7,
                tenues = {
                    ["Duty"] = { 
                        id = 1,
                        haut= 486, varHaut = 0, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 219, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Operation"] = { 
                        id = 2,
                        haut= 568, varHaut = 2, 
                        sousHaut = 268, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 64, varChaussures = 0, 
                        sac = 189, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 202, varPantalon = 4,
                        helmet = 207, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                },
            },
            ["Divers"] = {
                id = 8,
                tenues = {
                    ["Bike"] = { 
                        id = 1,
                        haut= 571, varHaut = 1, 
                        sousHaut = 242, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 14, varBras = 0,
                        chaussures = 130, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 171, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Boat #1"] = { 
                        id = 2,
                        haut= 556, varHaut = 2, 
                        sousHaut = 242, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 14, varBras = 0,
                        chaussures = 16, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 188, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Boat #2"] = { 
                        id = 3,
                        haut= 545, varHaut = 0, 
                        sousHaut = 242, varSousHaut = 0, 
                        chaine = 0, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 16, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 17, varPantalon = 4,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                },
            },
            ["Coroner"] = {
                id = 9,
                tenues = {
                    ["Classe-B"] = { 
                        id = 1,
                        haut= 551, varHaut = 8, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 101, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                    ["Classe-C"] = { 
                        id = 2,
                        haut= 550, varHaut = 8, 
                        sousHaut = 292, varSousHaut = 0, 
                        chaine = 162, varChaine = 0, 
                        bras = 106, varBras = 1,
                        chaussures = 107, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 195, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        glasses = -1, varGlasses = 0,
                        decals = 0, varDecals = 0
                    },
                }
            },  
        }
        for k,v in pairs(listGradeF_SAMS) do
            table.insert(dataVestiaireSAMS.catalogue, {
                    id= v.id,
                    label = k,
                    image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Vestiaire/SAMS/Grades/SAMS.webp",
                    category= "Grades",
                    subCategory = "Grades",
                    idVariation= v.id,
            })
            for i,j in pairs(v.tenues) do
                if j.id ~= nil then
                    table.insert(dataVestiaireSAMS.catalogue, {
                        id= j.id,
                        label = i,
                        image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Vestiaire/SAMS/Tenues/Femme/"..v.id.."/"..j.id..".webp",
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
        data = dataVestiaireSAMS
    }))
end 