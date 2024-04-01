CreateThread(function()
    while RegisterServerCallback == nil do
        Wait(1)
    end

    RegisterServerCallback("core:ChangePropertyCar", function(source, token, plate, model, props, id, crew)
        if CheckPlayerToken(source, token) then
            if plate ~= nil then
                local vente = nil
                local job = nil
                local owner = GetPlayer(id):getId()
                local origin = 'particulier: ' .. owner
                if crew == "job" then
                    job = GetPlayer(id):getJob()
                    origin = 'job: ' .. job
                elseif crew == 'crew' then
                    vente = GetPlayer(id):getCrew()
                    origin = 'crew: ' .. vente
                end
                print("plate", plate)
                MySQL.Async.execute("UPDATE vehicles SET vehicles.owner = @owner, vehicles.vente = @vente, vehicles.coowner = @co, vehicles.job = @job WHERE vehicles.plate = @plate",
                    {
                        ['@owner'] = owner,
                        ['@plate'] = plate,
                        ['@vente'] = vente,
                        ['@co'] = json.encode({}),
                        ['@job'] = job,
                    }, function(affectedRows)
                        if affectedRows == 0 then
                            TriggerClientEvent("__vision::createNotification", id, {
                                type = 'ROUGE',
                                -- duration = 5, -- In seconds, default:  4
                                content = "erreur avec le véhicule immatriculé [ ~s " .. plate .. " ~c ]"
                            })
                        else
                            SendDiscordLog("pawnshop", source, string.sub(GetDiscord(source), 9, -1), GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(),
                                id, string.sub(GetDiscord(id), 9, -1), GetPlayer(id):getLastname() .. " " .. GetPlayer(id):getFirstname(),
                                "changement de proprietaire " .. origin, plate, GetVehicle(plate):getOwner())
                            GetVehicle(plate):changeOwner(owner, vente, job)
                        end
                    --[[TriggerClientEvent("core:ShowNotification", id,
                        "vous êtes le nouveau propriétaire du véhicule immatriculé [~b~" .. plate .. "~s~]")]]
                    TriggerClientEvent("__vision::createNotification", id, {
                        type = 'JAUNE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "Vous êtes le nouveau propriétaire du véhicule immatriculé [ ~s " .. plate .. " ~c ]"
                    })
                end)
                --RemovePlayerVehKey(id, plate)
                --if crew == 'individuel' then AddPlayerVehKey(id, plate) end
                --RemoveSelledCar(plate)
                --GetPlayerVehicle(GetVehicleIndexFromPlate(plate), true)
                --GetPlayerVehicle(id, true)
                return true
            end
            return false
        else
            --TODO: AC Detection
        end
    end)

    RegisterServerCallback("core:CasseDeleteVeh", function(source, token, plate)
        if CheckPlayerToken(source, token) then
            local index = GetVehicleIndexFromPlate(plate)
            local type = nil
            if index ~= 0 then
                -- véhicule joueur
                if vehicles[index][plate] ~= nil then
                    vehicles[index][plate] = nil
                    MarkVehicleAsNotSaved(index, plate)
                    type = "joueur"
                    return type
                end
            else
                -- Véhicule volé
                type = "volé"
                return type
            end
        else
            return nil
        end
    end)

    RegisterServerCallback("core:AddCoOwners", function(source, token, plate, id)
        if CheckPlayerToken(source, token) then
            local veh = GetVehicle(plate)
            if veh ~= nil then
                SendDiscordLog("pawnshop", source, string.sub(GetDiscord(source), 9, -1), GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(),
                    id, string.sub(GetDiscord(id), 9, -1), GetPlayer(id):getLastname() .. " " .. GetPlayer(id):getFirstname(),
                    "ajout de coproprietaire", plate, GetVehicle(plate):getOwner())
                veh:AddCoowner(GetPlayer(id):getId())
                return true
            end
            return false
        else
            --TODO: AC Detection
        end
    end)

    RegisterServerCallback("core:AcceptChangeCar", function(source, token, plate)
        if CheckPlayerToken(source, token) then
            local index = GetVehicleIndexFromPlate(plate)
            -- print(index)
            if index ~= 0 then
                if vehicles[index][plate] ~= nil then
                    if vehicles[index][plate].vente == nil then
                        for k, v in pairs(players) do
                            if GetPlayer(k):getId() == vehicles[index][plate].owner then
                                local var = TriggerClientCallback(tonumber(k), "core:AcceptChangeCar")
                                return var
                            end
                            -- body
                        end
                    else
                        return true
                    end
                end
            end
            return false
        else
            --TODO: AC Detection
        end
    end)

    RegisterServerCallback("core:AcceptCasseCar", function(source, token, plate)
        if CheckPlayerToken(source, token) then
            local index = GetVehicleIndexFromPlate(plate)
            if index ~= 0 then
                if vehicles[index][plate] ~= nil then
                    -- si la voiture est vendue en individuel
                    if vehicles[index][plate].vente == nil then
                        for k, v in pairs(players) do
                            if GetPlayer(k):getId() == vehicles[index][plate].owner then
                                local var = TriggerClientCallback(tonumber(k), "core:AcceptCasseCar")
                                return var
                            end
                            -- body
                        end
                    else
                        -- si la voiture est vendue en groupe
                        return false
                    end
                end
            else
                -- si la voiture est volée
                return true
            end
            return false
        else
            --TODO: AC Detection
        end
    end)

    RegisterServerCallback("core:AddCoOwner", function(source, token, plate)
        if CheckPlayerToken(source, token) then
            local index = GetVehicleIndexFromPlate(plate)
            if index ~= 0 then
                if vehicles[index][plate] ~= nil then
                    if vehicles[index][plate].vente == nil then
                        for k, v in pairs(players) do
                            if GetPlayer(k):getId() == vehicles[index][plate].owner then
                                local var = TriggerClientCallback(tonumber(k), "core:AddCoOwner")

                                return var
                            end
                            -- body
                        end
                    else
                        return true
                    end
                end
            end
            return false
        else
            --TODO: AC Detection
        end
    end)
end)

RegisterNetEvent("core:casseLog")
AddEventHandler("core:casseLog", function(token, plate, model, price, type)
    SendDiscordLog("casse", source, string.sub(GetDiscord(source), 9, -1), GetPlayer(source):getLastname() .. " " .. GetPlayer(source):getFirstname(), plate, model, price, type)
end)