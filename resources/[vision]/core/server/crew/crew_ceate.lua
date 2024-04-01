-- function RefreshCrewMemberCount(crewName)
--     local mCount = 1
--     for k, v in pairs(crew[crewName].members) do
--         mCount = mCount + 1
--     end

--     crew[crewName].memberCount = mCount
-- end

RegisterNetEvent("core:CreateRank")
AddEventHandler("core:CreateRank", function(token, nameCrew, name, id)
    local src = source

    if CheckPlayerToken(src, token) then
        crew.createRank(nameCrew, name, id)

       -- TriggerClientEvent("core:ShowNotification", src, "Vous venez de créer le rank " .. name)

        -- New notif
        TriggerClientEvent("__vision::createNotification", src, {
            type = 'JAUNE',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous venez de créer le rank ~s" .. name .. "."
        })

    else
        --AC
    end
end)

RegisterNetEvent("core:deleteRank")
AddEventHandler("core:deleteRank", function(token, nameCrew, id)
    local src = source

    if CheckPlayerToken(src, token) then
        crew.deleteRank(nameCrew, id)

        -- TriggerClientEvent("core:ShowNotification", src, "Vous venez de supprimer le rank " .. id)

        -- New notif
        TriggerClientEvent("__vision::createNotification", src, {
            type = 'VERT',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous venez de supprimer le rank ~s " .. id
        })

    else
        --AC
    end
end)

RegisterNetEvent("core:setPerm")
AddEventHandler("core:setPerm", function(token, nameCrew, rank, perms)
    local src = source
    local data = {
        sellVeh = perms.sellVeh,
        keyVeh = perms.keyVeh,
        gest = perms.gest,
        prop = perms.prop,
        stockage = perms.stockage,
    }
    if CheckPlayerToken(src, token) then
        crew.setPermRank(nameCrew, rank, data)

        -- TriggerClientEvent("core:ShowNotification", src, "Vous venez de set les perms " .. rank)
        
        -- New notif
        TriggerClientEvent("__vision::createNotification", src, {
            type = 'VERT',
            -- duration = 5, -- In seconds, default:  4
            content = "Vous venez de set les perms ~s " .. rank
        })

    else
        --AC
    end
end)

RegisterNetEvent("core:CreateCrew")
AddEventHandler("core:CreateCrew", function(token, data)
    local src = source
    local player = GetPlayer(src)
    if CheckPlayerToken(source, token) then
        if data ~= nil then
            if data.color then
                if crew.newCreateCrew(src, data.name, data.tag, 1, data.color, data.devise) then
                    for k, v in pairs(data.grade) do
                        crew.createRank(data.name, v.name, v.id)
                    end
                    if crew.addPlayerInCrew(player:getId(), crew.getCrewId(data.name), 1) then
                        player:setCrew(data.name)
                        triggerEventPlayer("core:setCrewPlayer", src, data.name)
                        --RefreshPlayerData(src)
                    else
                        --[[ Ancienne notif
                        TriggerClientEvent("core:ShowNotification", src,
                            "Un problème est survenu lors de la création du crew.")
                        --]]
                        
                        -- New notif
                        TriggerClientEvent("__vision::createNotification", src, {
                            type = 'ROUGE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Un problème est survenu lors de la création du crew."
                        })
                    end
                    -- TriggerClientEvent("core:ShowNotification", src, "Vous venez de créer le crew " .. data.name)

                    TriggerClientEvent("__vision::createNotification", src, {
                        type = 'VERT',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous venez de créer le crew ~s" .. data.name
                    })
                else
                    -- TriggerClientEvent("core:ShowNotification", src, "Un problème est survenu lors de la création du crew.")

                    TriggerClientEvent("__vision::createNotification", src, {
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Un problème est survenu lors de la création du crew."
                    })
                end
            else
                if crew.createCrew(src, data.name, data.tag, 1) then
                    for k, v in pairs(data.grade) do
                        crew.createRank(data.name, v.name, v.id)
                    end
                    if crew.addPlayerInCrew(player:getId(), crew.getCrewId(data.name), 1) then
                        player:setCrew(data.name)
                        triggerEventPlayer("core:setCrewPlayer", src, data.name)
                        --RefreshPlayerData(src)
                    else
                        --[[ Ancienne notification
                        TriggerClientEvent("core:ShowNotification", src,
                            "Un problème est survenu lors de la création du crew.")
                        --]]

                        -- New notif
                        TriggerClientEvent("__vision::createNotification", src, {
                            type = 'ROUGE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Un problème est survenu lors de la création du crew."
                        })
                    end
                    
                    -- TriggerClientEvent("core:ShowNotification", src, "Vous venez de créer le crew " .. data.name)

                    -- New notif
                    TriggerClientEvent("__vision::createNotification", src, {
                        type = 'VERT',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous venez de créer le crew ~s" .. data.name
                    })
                else
                    -- TriggerClientEvent("core:ShowNotification", src, "Un problème est survenu lors de la création du crew.")
                    
                    -- New notif
                    TriggerClientEvent("__vision::createNotification", src, {
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Un problème est survenu lors de la création du crew."
                    })
                end
            end
        end
    end
end)

RegisterNetEvent('core:setCrew')
AddEventHandler('core:setCrew', function(token, id, name, rank)
    local source = source
    local player = GetPlayer(id)
    print("PlayerCrew", player)
    if CheckPlayerToken(source, token) then
        if name == "None" then
            if crew.removePlayerInCrew(player:getId(), crew.getCrewId(player:getCrew())) then
                player:setCrew("None")
            end
        elseif crew.DoesCrewExist(name) then
            if player:getCrew() ~= "None" then
                local currentCrew = player:getCrew()
                if crew.removePlayerInCrew(player:getId(), crew.getCrewId(currentCrew)) then
                    if crew.addPlayerInCrew(player:getId(), crew.getCrewId(name), tonumber(rank)) then
                        player:setCrew(name)
                        triggerEventPlayer("core:setCrewPlayer", source, name)
                        --RefreshPlayerData(id)
                        TriggerClientEvent('core:setCrew', id, name)

                        TriggerClientEvent("__vision::createNotification", source, {
                            type = 'VERT',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez recruté " .. player:getLastname() .. " " .. player:getFirstname()
                        })

                        TriggerClientEvent("__vision::createNotification", id, {
                            type = 'JAUNE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Vous avez été ~s recruté ~c dans un crew"
                        })

                    end
                end
            else
                if crew.addPlayerInCrew(player:getId(), crew.getCrewId(name), tonumber(rank)) then
                    player:setCrew(name)
                    triggerEventPlayer("core:setCrewPlayer", source, name)
                    --RefreshPlayerData(id)
                    TriggerClientEvent('core:setCrew', id, name)

                    --[[ Ancienne Notification
                    TriggerClientEvent("core:ShowNotification", source,
                        "Vous avez recruté " ..
                        player:getLastname() .. " " .. player:getFirstname())
                    TriggerClientEvent("core:ShowNotification", id, "Vous avez été recruté dans un crew")
                    --]]

                    -- New notif
                    TriggerClientEvent("__vision::createNotification", source, {
                        type = 'VERT',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous avez recruté " .. player:getLastname() .. " " .. player:getFirstname()
                    })

                    TriggerClientEvent("__vision::createNotification", id, {
                        type = 'JAUNE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous avez été ~s recruté ~c dans un crew"
                    })

                end
            end
        end
    end
end)