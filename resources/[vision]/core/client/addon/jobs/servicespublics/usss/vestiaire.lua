local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)


RegisterNUICallback("progressMenuUSSS", function(data)
        local gradeTenue = nil
        local typeTenue = nil 
        local tenue = nil
        if data.sousCategory == "Tenues" then
            gradeTenue = data.TenueGrade
            typeTenue = data.label
            if p:isMale() then
                tenue = listGradeM_USSS[gradeTenue].tenues[typeTenue]
            else
                tenue = listGradeF_USSS[gradeTenue].tenues[typeTenue]
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

function USSSVestiaireDev()
    local dataVestiaireUSSS = {}
    dataVestiaireUSSS = {
        catalogue= {},
        headerIcon= 'assets/icons/market-cart.png',
        headerIconName= 'Vestiaire',
        callbackName= 'progressMenuUSSS',
        progressBar= {
            {
                name= 'Grades'
            }, 
            {
                name= 'Tenues'
           }
        },
        headerImage= 'assets/headers/header_usss.jpg'
    }

    if p:isMale() then
        listGradeM_USSS = {
            ["UDO"] = {
                id = 1,
                tenues = {
                    ["Classe-A (PA-FA)"] = { 
                        id = 1,
                        haut= 489, varHaut = 7, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        mask = 227, varMask = 0
                    },
                    ["Classe-A (SA)"] = { 
                        id = 2,
                        haut= 489, varHaut = 7, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 160, varDecals = 0
                    },
                    ["Classe-A (SSA)"] = { 
                        id = 3,
                        haut= 489, varHaut = 7, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 160, varDecals = 2
                    },
                    ["Classe-A (SUP)"] = { 
                        id = 4,
                        haut= 489, varHaut = 7, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 160, varDecals = 3
                    },
                    ["Classe-A (CSUP)"] = { 
                        id = 5,
                        haut= 489, varHaut = 7, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 150, varDecals = 0
                    },
                    ["Classe-A (SUR)"] = { 
                        id = 6,
                        haut= 489, varHaut = 7, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 150, varDecals = 6
                    },
                    ["Classe-A (ASS)"] = { 
                        id = 7,
                        haut= 489, varHaut = 7, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 150, varDecals = 7
                    },
                    ["Classe-A (COO)"] = { 
                        id = 8,
                        haut= 489, varHaut = 7, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 150, varDecals = 8
                    },
                    ["Classe-B (PA-FA)"] = { 
                        id = 9,
                        haut= 486, varHaut = 11, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        mask = 227, varMask = 0
                    },
                    ["Classe-B (SA)"] = { 
                        id = 10,
                        haut= 486, varHaut = 11, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 160, varDecals = 0
                    },
                    ["Classe-B (SSA)"] = { 
                        id = 11,
                        haut= 486, varHaut = 11, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 160, varDecals = 2
                    },
                    ["Classe-B (SUP)"] = { 
                        id = 12,
                        haut= 486, varHaut = 11,
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 160, varDecals = 3
                    },
                    ["Classe-B (CSUP)"] = { 
                        id = 13,
                        haut= 486, varHaut = 11, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 158, varDecals = 0
                    },
                    ["Classe-B (SUR)"] = { 
                        id = 14,
                        haut= 486, varHaut = 11, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 158, varDecals = 6
                    },
                    ["Classe-B (ASS)"] = { 
                        id = 15,
                        haut= 486, varHaut = 11,
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 158, varDecals = 7
                    },
                    ["Classe-B (COO)"] = { 
                        id = 16,
                        haut= 486, varHaut = 11,
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 150, varDecals = 8
                    },
                    ["Classe-C (PA-FA)"] = { 
                        id = 17,
                        haut= 484, varHaut = 11, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 11, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        mask = 227, varMask = 0
                    },
                    ["Classe-C (SA)"] = { 
                        id = 18,
                        haut= 484, varHaut = 11, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 11, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 146, varDecals = 0
                    },
                    ["Classe-C (SSA)"] = { 
                        id = 19,
                        haut= 484, varHaut = 11, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 11, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 159, varDecals = 0
                    },
                    ["Classe-C (SUP)"] = { 
                        id = 20,
                        haut= 484, varHaut = 11, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 11, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 147, varDecals = 0
                    },
                    ["Classe-C (CSUP)"] = { 
                        id = 21,
                        haut= 484, varHaut = 11, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 11, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 158, varDecals = 0
                    },
                    ["Classe-C (SUR)"] = { 
                        id = 22,
                       haut= 484, varHaut = 11, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 11, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 158, varDecals = 6
                    },
                    ["Classe-C (ASS)"] = { 
                        id = 23,
                        haut= 484, varHaut = 11, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 11, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 158, varDecals = 7
                    },
                    ["Classe-C (COO)"] = { 
                        id = 24,
                        haut= 484, varHaut = 11, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 11, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 188, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 158, varDecals = 8
                    },
                    ["UDO BIKE"] = { 
                        id = 25,
                        haut= 447, varHaut = 3, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 0, varBras = 0,
                        chaussures = 126, varChaussures = 0, 
                        gpb = 81, varGpb = 0, 
                        pantalon = 165, varPantalon = 1,
                        mask = 227, varMask = 0,
                        helmet = 203, varHelmet = 1
                    },
                    ["UDO WINTER"] = { 
                        id = 26,
                        haut= 458, varHaut = 0, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 202, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        mask = 227, varMask = 0
                    },
                    ["UDO LOP"] = { 
                        id = 27,
                        haut= 529, varHaut = 5, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 172, varChaine = 0, 
                        bras = 0, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 9, varPantalon = 1,
                        helmet = -1, varHelmet = 0,
                        mask = 227, varMask = 0
                    },
                    ["UDO SPRING"] = { 
                        id = 28,
                        haut= 494, varHaut = 6, 
                        sousHaut = 202, varSousHaut = 0, 
                        chaine = 214, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 105, varGpb = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                },
            },
            ["CPO"] = {
                id = 2,
                tenues = {
                    ["CPO AGENT G"] = { 
                        id = 1,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO AGENT R"] = {
                        id = 2,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 1, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO AGENT B"] = {
                        id = 3,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 2, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO AGENT GC"] = {
                        id = 4,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 3, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO AGENT BR"] = {
                        id = 5,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 4, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO AGENT NR"] = {
                        id = 6,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 5, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO AGENT BFR"] = {
                        id = 7,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 6, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO SUP BFR"] = {
                        id = 8,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 14, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO SUP GF"] = {
                        id = 9,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 15, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO SUP R"] = {
                        id = 10,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 16, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO SUP BF"] = {
                        id = 11,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 17, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO SUP G"] = {
                        id = 12,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 18, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO SUP BR"] = {
                        id = 13,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 19, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO SUP BFR 2"] = {
                        id = 14,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 20, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO CO BFR"] = {
                        id = 15,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 7, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO CO GF"] = {
                        id = 16,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 8, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO CO R"] = {
                        id = 17,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 9, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO CO B"] = {
                        id = 18,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 10, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO CO GC"] = {
                        id = 19,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 11, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO CO BCR"] = {
                        id = 20,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 12, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    },
                    ["CPO COO BFR"] = {
                        id = 21,
                        haut= 443, varHaut = 0, 
                        sousHaut = 178, varSousHaut = 0, 
                        chaine = 220, varChaine = 13, 
                        bras = 4, varBras = 0,
                        chaussures = 104, varChaussures = 1, 
                        sac = 129, varSac = 0, 
                        gpb = 72, varGpb = 3, 
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 202, varPantalon = 0
                    }                  
                },
            }, 
            ["TS"] = {
                id = 3,
                tenues = {
                    ["TS TRAINER"] = { 
                        id = 1,
                        haut= 447, varHaut = 4, 
                        sousHaut = 221, varSousHaut = 0,  
                        chaine = 214, varChaine = 0, 
                        bras = 0, varBras = 0,
                        chaussures = 97, varChaussures = 0, 
                        gpb = 81, varGpb = 0, 
                        mask = 227, varMask = 0, 
                        pantalon = 200, varPantalon = 5,
                        helmet = -1, varHelmet = 0
                    },
                    ["TS TRAINEE"] = {
                        id = 2,
                        haut= 529, varHaut = 5, 
                        sousHaut = 221, varSousHaut = 0, 
                        chaine = 173, varChaine = 0, 
                        bras = 0, varBras = 0,
                        chaussures = 126, varChaussures = 0, 
                        pantalon = 165, varPantalon = 1,
                        helmet = -1, varHelmet = 0
                    }                  
                },
            }, 
            ["CST"] = {
                id = 4,
                tenues = {
                    ["CST SPOTTER ML"] = { 
                        id = 1,
                        haut= 563, varHaut = 12, 
                        sousHaut = 289, varSousHaut = 0,  
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 61, varChaussures = 0, 
                        gpb = 0, varGpb = 0, 
                        mask = 226, varMask = 0, 
                        pantalon = 9, varPantalon = 1,
                        helmet = 218, varHelmet = 24
                    },
                    ["CST MARKSMAN ML"] = {
                        id = 2,
                        haut= 563, varHaut = 12, 
                        sousHaut = 289, varSousHaut = 0,  
                        chaine = 172, varChaine = 0, 
                        bras = 4, varBras = 0,
                        chaussures = 61, varChaussures = 0, 
                        gpb = 0, varGpb = 0, 
                        mask = 226, varMask = 0, 
                        pantalon = 9, varPantalon = 7,
                        helmet = 218, varHelmet = 24
                    },
                     ["CST SPOTTER MC"] = { 
                        id = 3,
                        haut= 564, varHaut = 12, 
                        sousHaut = 289, varSousHaut = 0,  
                        chaine = 172, varChaine = 0, 
                        bras = 8, varBras = 0,
                        chaussures = 61, varChaussures = 0, 
                        gpb = 0, varGpb = 0, 
                        mask = 226, varMask = 0, 
                        pantalon = 9, varPantalon = 1,
                        helmet = 218, varHelmet = 24
                    },
                    ["CST MARKSMAN MC"] = {
                        id = 4,
                        haut= 564, varHaut = 12, 
                        sousHaut = 289, varSousHaut = 0,  
                        chaine = 172, varChaine = 0, 
                        bras = 8, varBras = 0,
                        chaussures = 61, varChaussures = 0, 
                        gpb = 0, varGpb = 0, 
                        mask = 226, varMask = 0, 
                        pantalon = 9, varPantalon = 7,
                        helmet = 218, varHelmet = 24
                    }                   
                },
            },
            ["CAT"] = {
                id = 5,
                tenues = {
                    ["CAT ML 1"] = { 
                        id = 1,
                        haut= 563, varHaut = 12, 
                        sousHaut = 289, varSousHaut = 0,  
                        chaine = 167, varChaine = 0, 
                        bras = 4, varBras = 0,
                        sac = 130, varSac = 9,
                        chaussures = 61, varChaussures = 0, 
                        gpb = 0, varGpb = 0,  
                        pantalon = 206, varPantalon = 4,
                        helmet = 213, varHelmet = 0,
                        glasses = 58, varGlasses = 0
                    },
                    ["CAT ML 2"] = {
                        id = 2,
                        haut= 563, varHaut = 12, 
                        sousHaut = 289, varSousHaut = 0,  
                        chaine = 167, varChaine = 0, 
                        bras = 4, varBras = 0,
                        sac = 130, varSac = 9,
                        chaussures = 61, varChaussures = 0, 
                        gpb = 0, varGpb = 0,  
                        pantalon = 206, varPantalon = 4,
                        helmet = 214, varHelmet = 0,
                        glasses = 58, varGlasses = 0
                    },
                    ["CAT MC 1"] = {
                        id = 3,
                        haut= 564, varHaut = 12, 
                        sousHaut = 289, varSousHaut = 0,  
                        chaine = 167, varChaine = 0, 
                        bras = 8, varBras = 0,
                        sac = 130, varSac = 9,
                        chaussures = 61, varChaussures = 0, 
                        gpb = 0, varGpb = 0,  
                        pantalon = 206, varPantalon = 4,
                        helmet = 213, varHelmet = 0,
                        glasses = 58, varGlasses = 0
                    }, 
                    ["CAT MC 2"] = {
                        id = 4,
                        haut= 564, varHaut = 12, 
                        sousHaut = 289, varSousHaut = 0,  
                        chaine = 167, varChaine = 0, 
                        bras = 8, varBras = 0,
                        sac = 130, varSac = 9,
                        chaussures = 61, varChaussures = 0, 
                        gpb = 0, varGpb = 0,  
                        pantalon = 206, varPantalon = 4,
                        helmet = 214, varHelmet = 0,
                        glasses = 58, varGlasses = 0
                    }                     
                },
            },  
            ["HAMMER"] = {
                id = 6,
                tenues = {
                    ["Démineur"] = { 
                        id = 1,
                        haut= 560, varHaut = 0, 
                        sousHaut = 15, varSousHaut = 0,  
                        chaine = 0, varChaine = 0, 
                        bras = 96, varBras = 0,
                        sac = 0, varSac = 0,
                        chaussures = 13, varChaussures = 0, 
                        gpb = 0, varGpb = 0,  
                        pantalon = 11, varPantalon = 0,
                        helmet = 209, varHelmet = 0,
                        mask = 228, varMask = 0
                    },
                    ["NRB"] = {
                        id = 2,
                        haut= 67, varHaut = 1, 
                        sousHaut = 62, varSousHaut = 1,  
                        chaine = 217, varChaine = 0, 
                        bras = 96, varBras = 0,
                        sac = 0, varSac = 0,
                        chaussures = 110, varChaussures = 0, 
                        gpb = 0, varGpb = 0,  
                        pantalon = 40, varPantalon = 1,
                        helmet = 213, varHelmet = 0,
                        mask = 224, varMask = 0
                    },
                    ["Médic MC"] = { 
                        id = 3,
                        haut= 564, varHaut = 4, 
                        sousHaut = 289, varSousHaut = 0,  
                        chaine = 167, varChaine = 0, 
                        bras = 177, varBras = 0,
                        sac = 130, varSac = 9,
                        chaussures = 61, varChaussures = 1, 
                        gpb = 0, varGpb = 0,  
                        pantalon = 200, varPantalon = 5,
                        helmet = 213, varHelmet = 1
                    },
                    ["Médic ML"] = { 
                        id = 4,
                        haut= 563, varHaut = 4, 
                        sousHaut = 289, varSousHaut = 0,  
                        chaine = 167, varChaine = 0, 
                        bras = 172, varBras = 0,
                        sac = 130, varSac = 9,
                        chaussures = 61, varChaussures = 1, 
                        gpb = 0, varGpb = 0,  
                        pantalon = 200, varPantalon = 5,
                        helmet = 213, varHelmet = 1
                    } 
                },
            },
            ["OI / OLIA"] = {
                id = 7,
                tenues = {
                    ["OLIA"] = { 
                        id = 1,
                        haut= 480, varHaut = 16, 
                        sousHaut = 255, varSousHaut = 1,  
                        chaine = 171, varChaine = 0, 
                        bras = 4, varBras = 0,
                        sac = 114, varSac = 5,
                        chaussures = 104, varChaussures = 1, 
                        gpb = 72, varGpb = 3,  
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0
                    },
                    ["OI"] = {
                        id = 2,
                        haut= 480, varHaut = 15, 
                        sousHaut = 255, varSousHaut = 1,  
                        chaine = 171, varChaine = 0, 
                        bras = 4, varBras = 0,
                        sac = 114, varSac = 8,
                        chaussures = 97, varChaussures = 0,  
                        gpb = 72, varGpb = 3,  
                        pantalon = 202, varPantalon = 0,
                        mask = 227, varMask = 0, 
                        helmet = -1, varHelmet = 0
                    }, 
                }
            },
        }
            for k,v in pairs(listGradeM_USSS) do
            table.insert(dataVestiaireUSSS.catalogue, {
                    id= v.id,
                    label = k,
                    image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Vestiaire/USSS/Grades/"..v.id..".webp",
                    category= "Grades",
                    subCategory = "Grades",
                    idVariation= v.id,
            })
            for i,j in pairs(v.tenues) do
                if j.id ~= nil then
                    table.insert(dataVestiaireUSSS.catalogue, {
                        id= j.id,
                        label = i,
                        image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Vestiaire/USSS/Tenues/Homme/"..v.id.."/"..j.id..".webp",
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
        listGradeF_USSS = {
            ["UDO"] = {
                id = 1,
                tenues = {
                    ["Classe-A (PA-FA)"] = { 
                        id = 1,
                        haut= 525, varHaut = 7, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        mask = 221, varMask = 0
                    },
                    ["Classe-A (SA)"] = { 
                        id = 2,
                        haut= 525, varHaut = 7, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 172, varDecals = 0
                    },
                     ["Classe-A (SSA)"] = { 
                        id = 3,
                        haut= 525, varHaut = 7, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 172, varDecals = 2
                    },
                     ["Classe-A (SUP)"] = { 
                        id = 4,
                        haut= 525, varHaut = 7, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 172, varDecals = 3
                    },
                     ["Classe-A (CSUP)"] = { 
                        id = 5,
                        haut= 525, varHaut = 7, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 162, varDecals = 0
                    },
                     ["Classe-A (SUR)"] = { 
                        id = 6,
                        haut= 525, varHaut = 7, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 162, varDecals = 6
                    },
                     ["Classe-A (ASS)"] = { 
                        id = 7,
                        haut= 525, varHaut = 7, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 162, varDecals = 7
                    },
                     ["Classe-A (COO)"] = { 
                        id = 8,
                        haut= 525, varHaut = 7, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 162, varDecals = 8
                    },
                  ["Classe-B (PA-FA)"] = { 
                        id = 9,
                        haut= 521, varHaut = 11, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        mask = 221, varMask = 0
                    },
                    ["Classe-B (SA)"] = { 
                        id = 10,
                        haut= 521, varHaut = 11, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 172, varDecals = 0
                    },
                     ["Classe-B (SSA)"] = { 
                        id = 11,
                        haut= 521, varHaut = 11, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 172, varDecals = 2
                    },
                     ["Classe-B (SUP)"] = { 
                        id = 12,
                        haut= 521, varHaut = 11, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 172, varDecals = 3
                    },
                     ["Classe-B (CSUP)"] = { 
                        id = 13,
                        haut= 521, varHaut = 11, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 170, varDecals = 0
                    },
                     ["Classe-B (SUR)"] = { 
                        id = 14,
                        haut= 521, varHaut = 11, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 170, varDecals = 6
                    },
                     ["Classe-B (ASS)"] = { 
                        id = 15,
                        haut= 521, varHaut = 11, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 170, varDecals = 7
                    },
                     ["Classe-B (COO)"] = { 
                        id = 16,
                        haut= 521, varHaut = 11, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 170, varDecals = 8
                    },
                    ["Classe-C (PA-FA)"] = { 
                        id = 17,
                        haut= 520, varHaut = 10, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 9, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        mask = 221, varMask = 0
                    },
                    ["Classe-C (SA)"] = { 
                        id = 18,
                        haut= 520, varHaut = 10, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 9, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 158, varDecals = 0
                    },
                     ["Classe-C (SSA)"] = { 
                        id = 19,
                        haut= 520, varHaut = 10, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 9, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 171, varDecals = 0
                    },
                     ["Classe-C (SUP)"] = { 
                        id = 20,
                        haut= 520, varHaut = 10, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 9, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 159, varDecals = 0
                    },
                     ["Classe-C (CSUP)"] = { 
                        id = 21,
                        haut= 520, varHaut = 10, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 9, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 170, varDecals = 0
                    },
                     ["Classe-C (SUR)"] = { 
                        id = 22,
                        haut= 520, varHaut = 10, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 9, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 170, varDecals = 6
                    },
                     ["Classe-C (ASS)"] = { 
                        id = 23,
                        haut= 520, varHaut = 10, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 9, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 170, varDecals = 7
                    },
                     ["Classe-C (COO)"] = { 
                        id = 24,
                        haut= 520, varHaut = 10, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 9, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 171, varSac = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 170, varDecals = 8
                    },
                     ["UDO BIKE"] = { 
                        id = 25,
                        haut= 566, varHaut = 3, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 14, varBras = 0,
                        chaussures = 130, varChaussures = 0, 
                        gpb = 80, varGpb = 0, 
                        pantalon = 171, varPantalon = 0,
                        mask = 221, varMask = 0,
                        helmet = 201, varHelmet = 1
                    },
                     ["UDO WINTER"] = { 
                        id = 26,
                        haut= 585, varHaut = 0, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        gpb = 61, varGpb = 0, 
                        pantalon = 169, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        mask = 221, varMask = 0
                    },
                     ["UDO LOP"] = { 
                        id = 27,
                        haut= 566, varHaut = 5, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 14, varBras = 0,
                        chaussures = 137, varChaussures = 0,  
                        gpb = 0, varGpb = 0, 
                        pantalon = 45, varPantalon = 2,
                        helmet = -1, varHelmet = 0,
                        mask = 221, varMask = 0
                    },
                    ["UDO SPRING"] = { 
                        id = 28,
                        haut= 527, varHaut = 5, 
                        sousHaut = 238, varSousHaut = 0, 
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        sac = 0, varSac = 0, 
                        gpb = 100, varGpb = 2, 
                        pantalon = 169, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        decals = 170, varDecals = 7
                    },
                },
            },
            ["CPO"] = {
                id = 2,
                tenues = {
                    ["CPO AGENT"] = { 
                        id = 1,
                        haut= 487, varHaut = 0, 
                        sousHaut = 217, varSousHaut = 0, 
                        chaine = 167, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 108, varChaussures = 1, 
                        sac = 125, varSac = 0, 
                        gpb = 71, varGpb = 7, 
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        pantalon = 169, varPantalon = 0
                    },
                    ["CPO SUP"] = {
                        id = 2,
                        haut= 487, varHaut = 0, 
                        sousHaut = 217, varSousHaut = 0, 
                        chaine = 167, varChaine = 2, 
                        bras = 3, varBras = 0,
                        chaussures = 108, varChaussures = 1, 
                        sac = 125, varSac = 0, 
                        gpb = 71, varGpb = 7, 
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        pantalon = 169, varPantalon = 0
                    },
                    ["CPO COO"] = {
                        id = 3,
                        haut= 487, varHaut = 0, 
                        sousHaut = 217, varSousHaut = 0, 
                        chaine = 167, varChaine = 1, 
                        bras = 3, varBras = 0,
                        chaussures = 108, varChaussures = 1, 
                        sac = 125, varSac = 0, 
                        gpb = 71, varGpb = 7, 
                        mask = 221, varMask = 0,
                        helmet = -1, varHelmet = 0,
                        pantalon = 169, varPantalon = 0
                    }                  
                },
            }, 
            ["TS"] = {
                id = 3,
                tenues = {
                    ["TS TRAINER"] = { 
                        id = 1,
                        haut= 566, varHaut = 5, 
                        sousHaut = 238, varSousHaut = 0,  
                        chaine = 141, varChaine = 0, 
                        bras = 14, varBras = 0,
                        chaussures = 137, varChaussures = 0, 
                        gpb = 80, varGpb = 0, 
                        mask = 221, varMask = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 181, varPantalon = 5
                    },
                    ["TS TRAINEE"] = {
                        id = 2,
                        haut= 566, varHaut = 5, 
                        sousHaut = 291, varSousHaut = 0, 
                        chaine = 142, varChaine = 0, 
                        bras = 14, varBras = 0,
                        chaussures = 130, varChaussures = 0, 
                        helmet = -1, varHelmet = 0,
                        pantalon = 207, varPantalon = 0
                    }                  
                },
            }, 
            ["CST"] = {
                id = 4,
                tenues = {
                    ["CST SPOTTER"] = { 
                        id = 1,
                        haut= 583, varHaut = 12, 
                        sousHaut = 303, varSousHaut = 0,  
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 64, varChaussures = 0, 
                        gpb = 0, varGpb = 0, 
                        mask = 224, varMask = 0, 
                        pantalon = 45, varPantalon = 1,
                        helmet = 216, varHelmet = 24
                    },
                    ["CST MARKSMAN"] = {
                        id = 2,
                        haut= 583, varHaut = 12, 
                        sousHaut = 303, varSousHaut = 0,  
                        chaine = 141, varChaine = 0, 
                        bras = 3, varBras = 0,
                        chaussures = 64, varChaussures = 0, 
                        gpb = 0, varGpb = 0, 
                        mask = 224, varMask = 0, 
                        pantalon = 45, varPantalon = 2,
                        helmet = 216, varHelmet = 24
                    },
                     ["CST SPOTTER MC"] = { 
                        id = 3,
                        haut= 584, varHaut = 12, 
                        sousHaut = 303, varSousHaut = 0,  
                        chaine = 141, varChaine = 0, 
                        bras = 1, varBras = 0,
                        chaussures = 64, varChaussures = 0, 
                        gpb = 0, varGpb = 0, 
                        mask = 224, varMask = 0, 
                        pantalon = 45, varPantalon = 1,
                        helmet = 216, varHelmet = 24
                    },
                    ["CST MARKSMAN MC"] = {
                        id = 4,
                        haut= 584, varHaut = 12, 
                        sousHaut = 303, varSousHaut = 0,  
                        chaine = 141, varChaine = 0, 
                        bras = 1, varBras = 0,
                        chaussures = 64, varChaussures = 0, 
                        gpb = 0, varGpb = 0, 
                        mask = 224, varMask = 0, 
                        pantalon = 45, varPantalon = 2,
                        helmet = 216, varHelmet = 24
                    }                    
                },
            },
            ["CAT"] = {
                id = 5,
                tenues = {
                    ["CAT ML 1"] = { 
                        id = 1,
                        haut= 583, varHaut = 12, 
                        sousHaut = 303, varSousHaut = 0,  
                        chaine = 136, varChaine = 0, 
                        bras = 3, varBras = 0,
                        sac = 172, varSac = 0, 
                        chaussures = 64, varChaussures = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 202, varPantalon = 4,
                        helmet = 207, varHelmet = 0,
                        glasses = 57, varGlasses = 0
                    },
                    ["CAT ML 2"] = {
                        id = 2,
                        haut= 583, varHaut = 12, 
                        sousHaut = 303, varSousHaut = 0,  
                        chaine = 136, varChaine = 0, 
                        bras = 3, varBras = 0,
                        sac = 172, varSac = 0, 
                        chaussures = 64, varChaussures = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 202, varPantalon = 4,
                        helmet = 206, varHelmet = 0,
                        glasses = 57, varGlasses = 0
                    },
                    ["CAT MC 1"] = {
                        id = 3,
                        haut= 584, varHaut = 12, 
                        sousHaut = 303, varSousHaut = 0,  
                        chaine = 136, varChaine = 0, 
                        bras = 0, varBras = 0,
                        sac = 172, varSac = 0, 
                        chaussures = 64, varChaussures = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 202, varPantalon = 4,
                        helmet = 207, varHelmet = 0,
                        glasses = 57, varGlasses = 0
                    },
                    ["CAT MC 2"] = {
                        id = 4,
                        haut= 584, varHaut = 12, 
                        sousHaut = 303, varSousHaut = 0,  
                        chaine = 136, varChaine = 0, 
                        bras = 0, varBras = 0,
                        sac = 172, varSac = 0, 
                        chaussures = 64, varChaussures = 0, 
                        gpb = 0, varGpb = 0, 
                        pantalon = 202, varPantalon = 4,
                        helmet = 206, varHelmet = 0,
                        glasses = 57, varGlasses = 0
                    }  
                },
            },     
            ["HAMMER"] = {
                id = 6,
                tenues = {
                    ["Démineur"] = { 
                        id = 1,
                        haut= 579, varHaut = 0, 
                        sousHaut = 15, varSousHaut = 0,  
                        chaine = 0, varChaine = 0, 
                        bras = 17, varBras = 0,
                        sac = 0, varSac = 0,
                        chaussures = 34, varChaussures = 0, 
                        gpb = 0, varGpb = 0,  
                        pantalon = 11, varPantalon = 0,
                        helmet = 217, varHelmet = 0,
                        mask = 226, varMask = 0
                    },
                    ["NRB"] = {
                        id = 2,
                        haut= 61, varHaut = 1, 
                        sousHaut = 43, varSousHaut = 1,  
                        chaine = 148, varChaine = 0, 
                        bras = 111, varBras = 0,
                        sac = 0, varSac = 0,
                        chaussures = 114, varChaussures = 0, 
                        gpb = 0, varGpb = 0,  
                        pantalon = 40, varPantalon = 1,
                        helmet = 207, varHelmet = 0,
                        mask = 225, varMask = 0
                    },
                    ["Médic MC"] = { 
                        id = 3,
                        haut= 584, varHaut = 4, 
                        sousHaut = 303, varSousHaut = 0,  
                        chaine = 136, varChaine = 0, 
                        bras = 220, varBras = 0,
                        sac = 172, varSac = 0,
                        chaussures = 64, varChaussures = 1, 
                        gpb = 0, varGpb = 0,  
                        pantalon = 181, varPantalon = 5,
                        helmet = 207, varHelmet = 1
                    },
                    ["Médic ML"] = { 
                        id = 4,
                        haut= 583, varHaut = 4, 
                        sousHaut = 220, varSousHaut = 0,  
                        chaine = 136, varChaine = 0, 
                        bras = 220, varBras = 0,
                        sac = 172, varSac = 0,
                        chaussures = 64, varChaussures = 1, 
                        gpb = 0, varGpb = 0,  
                        pantalon = 181, varPantalon = 5,
                        helmet = 207, varHelmet = 1
                    }
                },
            },   
            ["OI / OLIA"] = {
                id = 7,
                tenues = {
                    ["OLIA"] = { 
                        id = 1,
                        haut= 506, varHaut = 15, 
                        sousHaut = 217, varSousHaut = 0,  
                        chaine = 140, varChaine = 0, 
                        bras = 3, varBras = 0,
                        sac = 0, varSac = 0,
                        chaussures = 108, varChaussures = 1, 
                        gpb = 71, varGpb = 7,  
                        pantalon = 169, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        mask = 221, varMask = 0, 
                    },
                    ["OI"] = {
                        id = 2,
                        haut= 506, varHaut = 16, 
                        sousHaut = 217, varSousHaut = 0,  
                        chaine = 140, varChaine = 0, 
                        bras = 3, varBras = 0,
                        sac = 0, varSac = 0,
                        chaussures = 137, varChaussures = 0,
                        gpb = 71, varGpb = 7,  
                        pantalon = 169, varPantalon = 0,
                        helmet = -1, varHelmet = 0,
                        mask = 221, varMask = 0, 
                    }, 
                }
            }, 

        }
        for k,v in pairs(listGradeF_USSS) do
            table.insert(dataVestiaireUSSS.catalogue, {
                    id= v.id,
                    label = k,
                    image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Vestiaire/USSS/Grades/"..v.id..".webp",
                    category= "Grades",
                    subCategory = "Grades",
                    idVariation= v.id,
            })
            for i,j in pairs(v.tenues) do
                if j.id ~= nil then
                    table.insert(dataVestiaireUSSS.catalogue, {
                        id= j.id,
                        label = i,
                        image= "https://assets-vision-fa.cdn.purplemaze.net/assets/Vestiaire/USSS/Tenues/Femme/"..v.id.."/"..j.id..".webp",
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
        data = dataVestiaireUSSS
    }))
end
