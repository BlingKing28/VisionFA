local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

local call = false

local alerteTable = {}

RegisterNetEvent("core:callIncoming")
AddEventHandler("core:callIncoming", function(job, pos, targetData, msg, type)

    local dist = CalculateTravelDistanceBetweenPoints(p:pos(), pos)
    print("dist", dist, math.ceil(dist))
    local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(pos.x, pos.y, pos.z)) .. " (" ..
        math.ceil(dist) .. "m)"

    if job == 'lspd' then

        if targetData.name ~= '' then
            if msg ~= nil and msg ~= '' then
--[[                 ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: 911",
                    "~b~Identité: ~s~ " ..
                    targetData.name .. "\n~b~Localisation: ~s~" .. streetName .. "\n~b~Information: ~s~" .. msg,
                    "CHAR_CALL911",
                    "CHAR_CALL911") ]]

                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    jobicon = './police.svg',
                    title = 'POLICE',
                    content = msg, -- Raison (en haut à droite)
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    utils = "~K Y pour ~s accepter ou ~K N pour ~s l'ignorer",
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })

                local date = TriggerServerCallback("core:Heure")
                table.insert(alerteTable,
                    { job = "lspd", hour = date, name = targetData.name, street = streetName, mess = msg, pos = pos,
                        targetData = targetData, type = type })
            else
--[[                 ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: 911",
                    "~b~Identité: ~s~ " .. targetData.name .. "\n~b~Localisation: ~s~" .. streetName,
                    "CHAR_CALL911",
                    "CHAR_CALL911") ]]

                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    title = 'Centrale',
                    jobicon = './police.svg',
                    content = '',
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    utils = "~K Y pour ~s accepter ou ~K N pour ~s l'ignorer",
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })

                local date = TriggerServerCallback("core:Heure")
                table.insert(alerteTable,
                    { job = "lspd", hour = date, name = targetData.name, street = streetName, mess = msg, pos = pos,
                        targetData = targetData, type = type })
            end
        else
--[[             ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: 911",
                "~b~Identité: ~s~ Inconnu(e)\n~b~Localisation: ~s~" .. streetName .. "\n~b~Information: ~s~" .. msg,
                "CHAR_CALL911",
                "CHAR_CALL911") ]]

                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    title = 'Centrale',
                    jobicon = './police.svg',
                    content = msg, -- Raison (en haut à droite)
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    utils = "~K Y pour ~s accepter ou ~K N pour ~s l'ignorer",
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })


            local date = TriggerServerCallback("core:Heure")
            table.insert(alerteTable,
                { job = "lspd", hour = date, name = "Inconnu(e)", street = streetName, mess = msg, pos = pos,
                    targetData = targetData, type = type })

            -- ShowNotification("Appuyez sur ~g~Y~s~ pour accepter\nAppuyez sur ~r~N~s~ pour l'ignorer")

        end

            -- New notif
            -- exports['vNotif']:createNotification({
            --     type = 'VERT',
            --     duration = 10, -- In seconds, default:  4
            --     content = "Appuyer sur ~K Y pour ~s accepter"
            -- })

            -- exports['vNotif']:createNotification({
            --     type = 'ROUGE',
            --     duration = 10, -- In seconds, default:  4
            --     content = "Appuyer sur ~K N pour ~s l'ignorer"
            -- })

        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 0)


    elseif job == 'lssd' then

        if targetData.name ~= '' then
            if msg ~= nil and msg ~= '' then
    --[[                 ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: 911",
                    "~b~Identité: ~s~ " ..
                    targetData.name .. "\n~b~Localisation: ~s~" .. streetName .. "\n~b~Information: ~s~" .. msg,
                    "CHAR_CALL911",
                    "CHAR_CALL911") ]]

                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    jobicon = './police.svg',
                    title = 'POLICE',
                    content = msg, -- Raison (en haut à droite)
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })
    
                local date = TriggerServerCallback("core:Heure")
                table.insert(alerteTable,
                    { job = "lssd", hour = date, name = targetData.name, street = streetName, mess = msg, pos = pos,
                        targetData = targetData, type = type })
            else
    --[[                 ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: 911",
                    "~b~Identité: ~s~ " .. targetData.name .. "\n~b~Localisation: ~s~" .. streetName,
                    "CHAR_CALL911",
                    "CHAR_CALL911") ]]
    
                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    title = 'Centrale',
                    jobicon = './police.svg',
                    content = '',
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })
    
                local date = TriggerServerCallback("core:Heure")
                table.insert(alerteTable,
                    { job = "lssd", hour = date, name = targetData.name, street = streetName, mess = msg, pos = pos,
                        targetData = targetData, type = type })
            end
        else
    --[[             ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: 911",
                "~b~Identité: ~s~ Inconnu(e)\n~b~Localisation: ~s~" .. streetName .. "\n~b~Information: ~s~" .. msg,
                "CHAR_CALL911",
                "CHAR_CALL911") ]]
    
                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    title = 'Centrale',
                    jobicon = './police.svg',
                    content = msg, -- Raison (en haut à droite)
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })
    
    
            local date = TriggerServerCallback("core:Heure")
            table.insert(alerteTable,
                { job = "lssd", hour = date, name = "Inconnu(e)", street = streetName, mess = msg, pos = pos,
                    targetData = targetData, type = type })
    
            -- ShowNotification("Appuyez sur ~g~Y~s~ pour accepter\nAppuyez sur ~r~N~s~ pour l'ignorer")
    
        end
    
                -- New notif
            -- exports['vNotif']:createNotification({
            --     type = 'VERT',
            --     duration = 10, -- In seconds, default:  4
            --     content = "Appuyer sur ~K Y pour ~s accepter"
            -- })
    
            -- exports['vNotif']:createNotification({
            --     type = 'ROUGE',
            --     duration = 10, -- In seconds, default:  4
            --     content = "Appuyer sur ~K N pour ~s l'ignorer"
            -- })
    
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 0)
    elseif job == "bcms" then

        if targetData.lastName ~= '' then
            if msg ~= nil and msg ~= '' then
                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    title = 'BCMS',
                    jobicon = './sams.svg',
                    content = msg, -- Raison (en haut à droite)
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })

                local date = TriggerServerCallback("core:Heure")
                table.insert(alerteTable,
                    { job = "bcms", hour = date, name = "Inconnu(e)", street = streetName, mess = msg, pos = pos,
                        targetData = targetData, type = type })
            else
                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    title = 'BCMS',
                    jobicon = './sams.svg',
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })

                local date = TriggerServerCallback("core:Heure")
                table.insert(alerteTable,
                    { job = "bcms", hour = date, name = "Inconnu(e)", street = streetName, mess = msg, pos = pos,
                        targetData = targetData, type = type })
            end
        end
    elseif job == "ems" then

        if targetData.lastName ~= '' then
            if msg ~= nil and msg ~= '' then
--[[                 ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: 911",
                    "~b~Identité:~s~  " ..
                    targetData.name ..
                    " " ..
                    targetData.lastName .. "\n~b~Localisation: ~s~" .. streetName .. "\n~b~Information: ~s~" .. msg,
                    "CHAR_CALL911",
                    "CHAR_CALL911") ]]

                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    title = 'LSMS',
                    jobicon = './sams.svg',
                    content = msg, -- Raison (en haut à droite)
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })

                local date = TriggerServerCallback("core:Heure")
                table.insert(alerteTable,
                    { job = "ems", hour = date, name = "Inconnu(e)", street = streetName, mess = msg, pos = pos,
                        targetData = targetData, type = type })
            else
--[[                 ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: 911",
                    "~b~Identité:~s~ " ..
                    targetData.name .. " " .. targetData.lastName .. "\n~b~Localisation: ~s~" .. streetName,
                    "CHAR_CALL911",
                    "CHAR_CALL911")
 ]]
                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    title = 'LSMS',
                    jobicon = './sams.svg',
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })

                local date = TriggerServerCallback("core:Heure")
                table.insert(alerteTable,
                    { job = "ems", hour = date, name = "Inconnu(e)", street = streetName, mess = msg, pos = pos,
                        targetData = targetData, type = type })
            end
        else
--[[             ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: 911",
                "~b~Identité: ~s~ Inconnu(e)\n~b~Localisation: ~s~" .. streetName .. "\n~b~Information: ~s~" .. msg,
                "CHAR_CALL911",
                "CHAR_CALL911") ]]

                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    title = 'LSMS',
                    jobicon = './sams.svg',
                    content = msg, -- Raison (en haut à droite)
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })

        end
        -- ShowNotification("Appuyez sur ~g~Y~s~ pour accepter\nAppuyez sur ~r~N~s~ pour l'ignorer")

        -- New notif
        -- exports['vNotif']:createNotification({
        --     type = 'VERT',
        --     duration = 10, -- In seconds, default:  4
        --     content = "Appuyer sur ~K Y pour ~s accepter"
        -- })

        -- exports['vNotif']:createNotification({
        --     type = 'ROUGE',
        --     duration = 10, -- In seconds, default:  4
        --     content = "Appuyer sur ~K N pour ~s l'ignorer"
        -- })


        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 0)

    elseif job == "lsfd" then

        if targetData.lastName ~= '' then
            if msg ~= nil and msg ~= '' then
--[[                 ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: 911",
                    "~b~Identité:~s~  " ..
                    targetData.name ..
                    " " ..
                    targetData.lastName .. "\n~b~Localisation: ~s~" .. streetName .. "\n~b~Information: ~s~" .. msg,
                    "CHAR_CALL911",
                    "CHAR_CALL911") ]]

                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    title = 'LSFD',
                    jobicon = './sams.svg',
                    content = msg, -- Raison (en haut à droite)
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })

                local date = TriggerServerCallback("core:Heure")
                table.insert(alerteTable,
                    { job = "lsfd", hour = date, name = "Inconnu(e)", street = streetName, mess = msg, pos = pos,
                        targetData = targetData, type = type })
            else
--[[                 ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: 911",
                    "~b~Identité:~s~ " ..
                    targetData.name .. " " .. targetData.lastName .. "\n~b~Localisation: ~s~" .. streetName,
                    "CHAR_CALL911",
                    "CHAR_CALL911")
 ]]
                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    title = 'LSFD',
                    jobicon = './sams.svg',
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })

                local date = TriggerServerCallback("core:Heure")
                table.insert(alerteTable,
                    { job = "lsfd", hour = date, name = "Inconnu(e)", street = streetName, mess = msg, pos = pos,
                        targetData = targetData, type = type })
            end
        else
--[[             ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: 911",
                "~b~Identité: ~s~ Inconnu(e)\n~b~Localisation: ~s~" .. streetName .. "\n~b~Information: ~s~" .. msg,
                "CHAR_CALL911",
                "CHAR_CALL911") ]]

                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    title = 'LSFD',
                    jobicon = './sams.svg',
                    content = msg, -- Raison (en haut à droite)
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })

        end
        -- ShowNotification("Appuyez sur ~g~Y~s~ pour accepter\nAppuyez sur ~r~N~s~ pour l'ignorer")

        -- New notif
        -- exports['vNotif']:createNotification({
        --     type = 'VERT',
        --     duration = 10, -- In seconds, default:  4
        --     content = "Appuyer sur ~K Y pour ~s accepter"
        -- })

        -- exports['vNotif']:createNotification({
        --     type = 'ROUGE',
        --     duration = 10, -- In seconds, default:  4
        --     content = "Appuyer sur ~K N pour ~s l'ignorer"
        -- })


        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 0)

    elseif job == "usss" then

        if targetData.lastName ~= '' then
            if msg ~= nil and msg ~= '' then
--[[                 ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: USSS",
                    "~b~Identité:~s~  " ..
                    targetData.name ..
                    " " ..
                    targetData.lastName .. "\n~b~Localisation: ~s~" .. streetName .. "\n~b~Information: ~s~" .. msg,
                    "CHAR_CALL911",
                    "CHAR_CALL911") ]]

                    exports['vNotif']:createNotification({
                        type = 'ALERTEJOBS',
                        title = 'USSS',
                        jobicon = './police.svg',
                        content = msg, -- Raison (en haut à droite)
                        name = msg, -- Nom affiché
                        adress = streetName, -- Adresse
                        duration = 10, -- Durée seconde
                        distance = math.ceil(dist),
                    })

                local date = TriggerServerCallback("core:Heure")
                table.insert(alerteTable,
                    { job = "usss", hour = date, name = "Inconnu(e)", street = streetName, mess = msg, pos = pos,
                        targetData = targetData, type = type })
            else
--[[                 ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: USSS",
                    "~b~Identité:~s~ " ..
                    targetData.name .. " " .. targetData.lastName .. "\n~b~Localisation: ~s~" .. streetName,
                    "CHAR_CALL911",
                    "CHAR_CALL911") ]]

                    exports['vNotif']:createNotification({
                        type = 'ALERTEJOBS',
                        title = 'USSS',
                        jobicon = './police.svg',
                        name = msg, -- Nom affiché
                        adress = streetName, -- Adresse
                        duration = 10, -- Durée seconde
                        distance = math.ceil(dist),
                    })

                local date = TriggerServerCallback("core:Heure")
                table.insert(alerteTable,
                    { job = "usss", hour = date, name = "Inconnu(e)", street = streetName, mess = msg, pos = pos,
                        targetData = targetData, type = type })
            end
        else
--[[             ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: USSS",
                "~b~Identité: ~s~ Inconnu(e)\n~b~Localisation: ~s~" .. streetName .. "\n~b~Information: ~s~" .. msg,
                "CHAR_CALL911",
                "CHAR_CALL911")
 ]]
                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    title = 'USSS',
                    jobicon = './police.svg',
                    content = msg, -- Raison (en haut à droite)
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })

        end

        -- ShowNotification("Appuyez sur ~g~Y~s~ pour accepter\nAppuyez sur ~r~N~s~ pour l'ignorer")

            -- New notif
            -- exports['vNotif']:createNotification({
            --     type = 'VERT',
            --     duration = 10, -- In seconds, default:  4
            --     content = "Appuyer sur ~K Y pour ~s accepter"
            -- })
    
            -- exports['vNotif']:createNotification({
            --     type = 'ROUGE',
            --     duration = 10, -- In seconds, default:  4
            --     content = "Appuyer sur ~K N pour ~s l'ignorer"
            -- })

        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 0)
    elseif job == "bp" then
    

        if targetData.lastName ~= '' then
            if msg ~= nil and msg ~= '' then
--[[                 ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: G6",
                    "~b~Identité:~s~  " ..
                    targetData.name ..
                    " " ..
                    targetData.lastName .. "\n~b~Localisation: ~s~" .. streetName .. "\n~b~Information: ~s~" .. msg,
                    "CHAR_CALL911",
                    "CHAR_CALL911") ]]

                    exports['vNotif']:createNotification({
                        type = 'ALERTEJOBS',
                        title = 'Border Patrol',
                        jobicon = './police.svg',
                        content = msg, -- Raison (en haut à droite)
                        name = msg, -- Nom affiché
                        adress = streetName, -- Adresse
                        duration = 10, -- Durée seconde
                        distance = math.ceil(dist),
                    })

                local date = TriggerServerCallback("core:Heure")
                table.insert(alerteTable,
                    { job = "bp", hour = date, name = "Inconnu(e)", street = streetName, mess = msg, pos = pos,
                        targetData = targetData, type = type })
            else
--[[                 ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: bp",
                    "~b~Identité:~s~ " ..
                    targetData.name .. " " .. targetData.lastName .. "\n~b~Localisation: ~s~" .. streetName,
                    "CHAR_CALL911",
                    "CHAR_CALL911") ]]

                    exports['vNotif']:createNotification({
                        type = 'ALERTEJOBS',
                        title = 'BP',
                        jobicon = './police.svg',
                        name = msg, -- Nom affiché
                        adress = streetName, -- Adresse
                        duration = 10, -- Durée seconde
                        distance = math.ceil(dist),
                    })

                local date = TriggerServerCallback("core:Heure")
                table.insert(alerteTable,
                    { job = "bp", hour = date, name = "Inconnu(e)", street = streetName, mess = msg, pos = pos,
                        targetData = targetData, type = type })
            end
        else
--[[             ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: G6",
                "~b~Identité: ~s~ Inconnu(e)\n~b~Localisation: ~s~" .. streetName .. "\n~b~Information: ~s~" .. msg,
                "CHAR_CALL911",
                "CHAR_CALL911")     ]]    

                exports['vNotif']:createNotification({
                    type = 'ALERTEJOBS',
                    title = 'Border Patrol',
                    jobicon = './police.svg',
                    content = msg, -- Raison (en haut à droite)
                    name = msg, -- Nom affiché
                    adress = streetName, -- Adresse
                    duration = 10, -- Durée seconde
                    distance = math.ceil(dist),
                })

        end

        -- ShowNotification("Appuyez sur ~g~Y~s~ pour accepter\nAppuyez sur ~r~N~s~ pour l'ignorer")

            -- New notif
            -- exports['vNotif']:createNotification({
            --     type = 'VERT',
            --     duration = 10, -- In seconds, default:  4
            --     content = "Appuyer sur ~K Y pour ~s accepter"
            -- })
    
            -- exports['vNotif']:createNotification({
            --     type = 'ROUGE',
            --     duration = 10, -- In seconds, default:  4
            --     content = "Appuyer sur ~K N pour ~s l'ignorer"
            -- })

        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 0)
    else
        if targetData.lastName ~= '' then
            if msg ~= nil and msg ~= '' then
                --ShowAdvancedNotification("Accueil", "~b~Sonnette", "~b~Information: ~s~" .. msg, "CHAR_CALL911",
                --    "CHAR_CALL911")

                -- New notif
                exports['vNotif']:createNotification({
                    type = 'CLOCHE',
                    -- duration = 5, -- In seconds, default:  4
                    content = msg
                })

            end
        else
            --ShowAdvancedNotification("Accueil", "~b~Sonnette", "~b~Information: ~s~" .. msg, "CHAR_CALL911",
            --    "CHAR_CALL911")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'CLOCHE',
                -- duration = 5, -- In seconds, default:  4
                content = msg
            })

        end
        -- ShowNotification("Appuyez sur ~g~Y~s~ pour accepter\nAppuyez sur ~r~N~s~ pour l'ignorer")

            -- New notif
        -- exports['vNotif']:createNotification({
        --     type = 'VERT',
        --     duration = 10, -- In seconds, default:  4
        --     content = "Appuyer sur ~K Y pour ~s accepter"
        -- })

        -- exports['vNotif']:createNotification({
        --     type = 'ROUGE',
        --     duration = 10, -- In seconds, default:  4
        --     content = "Appuyer sur ~K N pour ~s l'ignorer"
        -- })

    end

    local timer = GetGameTimer() + 10000
    while true do
        if GetGameTimer() > timer then
            -- ShowNotification("Vous avez ignoré l'appel")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s ignoré l'appel"
            })

            return
        elseif IsControlJustPressed(0, 246) then
            if type == "illegal" then
                TriggerServerEvent('core:callAccept', job, pos, targetData, "illegal")
            elseif type == "drugs" then
                TriggerServerEvent('core:callAccept', job, pos, targetData, "drugs")
            else
                TriggerServerEvent('core:callAccept', job, pos, targetData)
            end
            return
        elseif IsControlJustPressed(0, 306) then
            -- ShowNotification("~r~Vous avez refusé l'appel")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s refusé l'appel"
            })

            return
        end
        Wait(0)
    end
end)


local blips = nil
RegisterNetEvent("core:callAccepted")
AddEventHandler("core:callAccepted", function(job, pos, targetData, type)
    Citizen.CreateThread(function()
        SetWaypointOff()
        if type == "drugs" then
            local random = math.random(100, 300.0)
            local random2 = math.random(1, 4)
            if random2 == 1 then
                pos = vector3(pos.x + random, pos.y + random, pos.z + random)
            elseif random2 == 2 then
                pos = vector3(pos.x + random, pos.y - random, pos.z + random)
            elseif random2 == 3 then
                pos = vector3(pos.x - random, pos.y + random, pos.z + random)
            elseif random2 == 4 then
                pos = vector3(pos.x - random, pos.y - random, pos.z + random)
            end
            if blips ~= nil then
                RemoveBlip(blips)
                blips = nil
            end
            if blips == nil then
                blips = AddBlipForRadius(pos, 500.0)
                SetBlipSprite(blips, 9)
                SetBlipColour(blips, 1)
                SetBlipAlpha(blips, 100)
                Modules.UI.RealWait(5 * 60000)
                RemoveBlip(blips)
            end
        else
            if call then
                RemoveBlip(blips)
                call = false
            end
            blips = AddBlipForCoord(pos)
            call = true
            SetBlipRoute(blips, true)
            -- ShowNotification("Vous avez pris l'appel")

            -- New notif
            exports['vNotif']:createNotification({
                type = 'VERT',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez ~s pris l'appel"
            })
            
            while true do
                Wait(1000)
                if #(pos.xyz - p:pos()) < 10.0 then
                    RemoveBlip(blips)
                    return
                end
            end
        end

    end)
end)

RegisterNetEvent("core:takeCall")
AddEventHandler("core:takeCall", function(type)
    if type == 'noAnswer' then
        -- ShowNotification("~r~Personne ne peut venir actuellement")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Personne ne peut venir actuellement"
        })

    elseif type == 'callAlrdyActive' then
        -- ShowNotification("~b~Veuillez rappeler dans quelques instants")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'ROUGE',
            -- duration = 5, -- In seconds, default:  4
            content = '~s Veuillez rappeler dans quelques instants'
        })

    elseif type == "callTake" then
        -- ShowNotification("~g~Quelqu'un arrive !")

        -- New notif
        exports['vNotif']:createNotification({
            type = 'CLOCHE',
            -- duration = 5, -- In seconds, default:  4
            content = "~s Quelqu'un arrive !"
        })

    end
end)
local char = "menu_title_police"
local open = false
local main = RageUI.CreateMenu("", "Historique des appels", 0.0, 0.0, "vision", char)
local spChoiceFrequence = RageUI.CreateSubMenu(main, "", "Frequences", 0.0, 0.0, "vision", "menu_title_police")

Keys.Register("F4", "F4", "Historique Alerte", function()
    if p:getJob() == "lspd" then
        char = "menu_title_police"
        main = RageUI.CreateMenu("", "Historique des appels", 0.0, 0.0, "vision", char)
        OpenAlerteMenu()
    elseif p:getJob() == "lssd" then
        char = "menu_title_police"
        main = RageUI.CreateMenu("", "Historique des appels", 0.0, 0.0, "vision", char)
        OpenAlerteMenu()
    elseif p:getJob() == "ems" or p:getJob() == "bcms" then
        char = "menu_title_ems"
        main = RageUI.CreateMenu("", "Historique des appels", 0.0, 0.0, "vision", char)
        OpenAlerteMenu()
    elseif p:getJob() == "lsfd" then
        char = "menu_title_ems"
        main = RageUI.CreateMenu("", "Historique des appels", 0.0, 0.0, "vision", char)
        OpenAlerteMenu()
    elseif p:getJob() == "usss" then
        char = "menu_title_usss"
        main = RageUI.CreateMenu("", "Historique des appels", 0.0, 0.0, "vision", char)
        OpenAlerteMenu()
    elseif p:getJob() == "bp" then
        char = "menu_title_bp"
        main = RageUI.CreateMenu("", "Historique des appels", 0.0, 0.0, "vision", char)
        OpenAlerteMenu()
    end
end)

main.Closed = function()
    open = false
end


function OpenAlerteMenu()
    if open then
        open = false
        RageUI.Visible(main, false)
    else
        open = true

        RageUI.Visible(main, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(main, function()
                    if alerteTable ~= nil then
                        --RageUI.Button("Rejoindre une fréquence", false, { RightLabel = ">" }, true, {
                        --    onSelected = function()
                        --        clsp_switchFrequence = TriggerServerCallback("radio:askfreq")
                        --    end
                        --}, spChoiceFrequence)
                        RageUI.Button("~r~Annuler le dernier appel", false, {}, true, {
                            onSelected = function()
                                if call then
                                    RemoveBlip(blips)
                                    call = false
                                end
                            end
                        })
                        for k, v in pairs(alerteTable) do
                            if v.job == "lspd" or v.job == "lssd" then
                                if k >= #alerteTable - 8 and k <= #alerteTable then
                                    RageUI.Button("[~b~" .. v.hour .. "~s~] " .. v.name .. " | " .. v.street, v.mess, {}
                                        , true, {
                                        onSelected = function()
--[[                                             ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: 911",
                                                "~b~Identité: ~s~ " .. v.name .. "\n~b~Localisation: ~s~" .. v.street,
                                                "CHAR_CALL911",
                                                "CHAR_CALL911") ]]
                                            -- ShowNotification("Appuyez sur ~g~Y~s~ pour accepter\nAppuyez sur ~r~N~s~ pour l'ignorer")
--
                                            -- New notif
                                            -- exports['vNotif']:createNotification({
                                            --     type = 'VERT',
                                            --     duration = 10, -- In seconds, default:  4
                                            --     content = "Appuyer sur ~K Y pour ~s accepter"
                                            -- })
--
                                            -- exports['vNotif']:createNotification({
                                            --     type = 'ROUGE',
                                            --     duration = 10, -- In seconds, default:  4
                                            --     content = "Appuyer sur ~K N pour ~s l'ignorer"
                                            -- })
--
                                            exports['vNotif']:createNotification({
                                                type = 'ALERTEJOBS',
                                                title = 'Centrale',
                                                jobicon = './police.svg',
                                                content = v.mess, -- Raison (en haut à droite)
                                                name = v.mess, -- Nom affiché
                                                adress = v.street, -- Adresse
                                                duration = 10, -- Durée seconde
                                            })
--
                                            local timer = GetGameTimer() + 10000
                                            RageUI.CloseAll()
                                            while true do
                                                if GetGameTimer() > timer then
                                                    -- ShowNotification("Vous avez ignoré l'appel")
--
                                                    -- New notif
                                                    exports['vNotif']:createNotification({
                                                        type = 'ROUGE',
                                                        -- duration = 5, -- In seconds, default:  4
                                                        content = "Vous avez ~s ignoré l'appel"
                                                    })
--
                                                    return
                                                elseif IsControlJustPressed(0, 246) then
                                                    if v.type == "illegal" then
                                                        TriggerServerEvent('core:callAccept', v.job, v.pos, v.targetData
                                                            , "illegal")
                                                    elseif v.type == "drugs" then
                                                        TriggerServerEvent('core:callAccept', v.job, v.pos, v.targetData
                                                            , "drugs")
                                                    else
                                                        TriggerServerEvent('core:callAccept', v.job, v.pos, v.targetData)
                                                    end
                                                    return
                                                elseif IsControlJustPressed(0, 306) then
                                                    -- ShowNotification("~r~Vous avez refusé l'appel")
--
                                                    -- New notif
                                                    exports['vNotif']:createNotification({
                                                        type = 'ROUGE',
                                                        -- duration = 5, -- In seconds, default:  4
                                                        content = "Vous avez ~s refusé l'appel"
                                                    })
--
                                                    return
                                                end
                                                Wait(0)
                                            end
                                        end
                                    })
                                end
                            else
                                if k >= #alerteTable - 8 and k <= #alerteTable then
                                    RageUI.Button("[~b~" .. v.hour .. "~s~] " .. v.name .. " | " .. v.street, v.mess, {}
                                        , true, {
                                        onSelected = function()
--[[                                             ShowAdvancedNotification("Centrale", "~b~Appel d'urgence: 911",
                                                "~b~Identité: ~s~ " .. v.name .. "\n~b~Localisation: ~s~" .. v.street,
                                                "CHAR_CALL911",
                                                "CHAR_CALL911") ]]
                                            -- ShowNotification("Appuyez sur ~g~Y~s~ pour accepter\nAppuyez sur ~r~N~s~ pour l'ignorer")
--
                                            -- New notif
                                            -- exports['vNotif']:createNotification({
                                            --     type = 'VERT',
                                            --     duration = 10, -- In seconds, default:  4
                                            --     content = "Appuyer sur ~K Y pour ~s accepter"
                                            -- })
--
                                            -- exports['vNotif']:createNotification({
                                            --     type = 'ROUGE',
                                            --     duration = 10, -- In seconds, default:  4
                                            --     content = "Appuyer sur ~K N pour ~s l'ignorer"
                                            -- })
--
                                            exports['vNotif']:createNotification({
                                                type = 'ALERTEJOBS',
                                                title = 'Centrale',
                                                jobicon = './police.svg',
                                                content = v.mess, -- Raison (en haut à droite)
                                                name = v.mess, -- Nom affiché
                                                adress = v.street, -- Adresse
                                                duration = 10, -- Durée seconde
                                            })
--
                                            local timer = GetGameTimer() + 10000
                                            RageUI.CloseAll()
                                            while true do
                                                if GetGameTimer() > timer then
                                                    -- ShowNotification("Vous avez ignoré l'appel")
--
                                                    -- New notif
                                                    exports['vNotif']:createNotification({
                                                        type = 'ROUGE',
                                                        -- duration = 10, -- In seconds, default:  4
                                                        content = "Vous avez ~s ignoré l'appel"
                                                    })
--
                                                    return
                                                elseif IsControlJustPressed(0, 246) then
                                                    if v.type == "illegal" then
                                                        TriggerServerEvent('core:callAccept', v.job, v.pos, v.targetData
                                                            , "illegal")
                                                    elseif v.type == "drugs" then
                                                        TriggerServerEvent('core:callAccept', v.job, v.pos, v.targetData
                                                            , "drugs")
                                                    else
                                                        TriggerServerEvent('core:callAccept', v.job, v.pos, v.targetData)
                                                    end
                                                    return
                                                elseif IsControlJustPressed(0, 306) then
                                                    -- ShowNotification("~r~Vous avez refusé l'appel")
--
                                                    -- New notif
                                                    exports['vNotif']:createNotification({
                                                        type = 'ROUGE',
                                                        -- duration = 5, -- In seconds, default:  4
                                                        content = "Vous avez ~s refusé l'appel"
                                                    })
--
                                                    return
                                                end
                                                Wait(0)
                                            end
                                        end
                                    })
                                end
                            end
                        end
                    end
                end)
                --RageUI.IsVisible(spChoiceFrequence, function()
                --    RageUI.Button("~g~United States Border Patrol", false, {}, true, {
                --        onSelected = function()
                --            exports['pma-voice']:setRadioChannel(clsp_switchFrequence.usbp)
                --        end
                --    })
                --    RageUI.Button("~y~Los Santos County Sheriff", false, {}, true, {
                --        onSelected = function()
                --            exports['pma-voice']:setRadioChannel(clsp_switchFrequence.lssd)
                --        end
                --    })
                --    RageUI.Button("~b~Los Santos Police Department", false, {}, true, {
                --        onSelected = function()
                --            exports['pma-voice']:setRadioChannel(clsp_switchFrequence.lspd)
                --        end
                --    })
                --    RageUI.Button("~r~Los Santos Fire Department", false, {}, true, {
                --        onSelected = function()
                --            exports['pma-voice']:setRadioChannel(clsp_switchFrequence.lsfd)
                --        end
                --    })
                --    RageUI.Button("~l~United States Secret Service", false, {}, true, {
                --        onSelected = function()
                --            exports['pma-voice']:setRadioChannel(clsp_switchFrequence.usss)
                --        end
                --    })
                --    RageUI.Button("~q~San Andreas Medical Service", false, {}, true, {
                --        onSelected = function()
                --            exports['pma-voice']:setRadioChannel(clsp_switchFrequence.sams)
                --        end
                --    })
                --end)
                Wait(1)
            end
        end)
    end
end

RegisterCommand("lastBlips", function()
    if p:getJob() == "lspd" or p:getJob() == "lssd" then
        char = "menu_title_police"
    elseif p:getJob() == "ems" or p:getJob("bcms") then
        char = "menu_title_ems"
    end
    OpenAlerteMenu()
end)

exports('GetJobPlayerData', function()
    local result = {}
    if print(json.encode(loadedJob)) ~= "[]" and p ~= nil then
        result.job = loadedJob.name
        result.label = loadedJob.label
        result.grade = pJobGrade
        result.gradeName = loadedJob.grade[pJobGrade].label
        result.isBoss = loadedJob.grade[pJobGrade].gestion
    end
    return result
end)

exports('getPlayerCompanyBank',function()
    local balance = TriggerServerCallback('core:getCompanyBalance', token)
    return balance
end)

exports('getEmployees',function()
    local employees = {}
    local getEmployees = TriggerServerCallback('core:getEmployees', token)
    for k,v in pairs(getEmployees) do
        local temp = {}
        temp.name = v.nom.." "..v.prenom
        temp.grade = v.grade
        temp.gradeLabel = loadedJob.grade[temp.grade].label
        temp.canInteract = loadedJob.grade[temp.grade].gestion
        table.insert(employees, temp)
    end
    return employees
end)

exports('getJobGrades',function()
    local grades = {}
    for k,v in pairs(loadedJob.grade) do
        local temp = {}
        temp.grade = k
        temp.label = v.label
        table.insert(grades, temp)
    end
    return grades
end)