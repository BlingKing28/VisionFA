local limit = {}

RegisterNetEvent("core:sellHunt")
AddEventHandler("core:sellHunt", function (token, name, price, quantity)
    -- get the source's database id
    local id = GetPlayer(source):getId()
    if id ~= nil then    
        if limit[id] == nil then
            limit[id] = 0
        end
        new_limit = tonumber(quantity) + limit[id]
        if CheckPlayerToken(source, token) then
            if DoesPlayerHaveItemCount(source, name, quantity) then
                if AddItemToInventory(source, "money", price * quantity, {}) then
                    if new_limit <= 234 then
                        RemoveItemFromInventory(source, name, quantity, {})
                        --[[TriggerClientEvent("core:ShowNotification", source, "~g~Tu as vendu x" .. quantity .. " ~o~" .. getItemLabel(name) .. "~s~ pour ~g~$" .. price * quantity .. "~s~")]]
                        TriggerClientEvent("__vision::createNotification", source, {
                            type = 'DOLLAR',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Tu as vendu ~s x" .. quantity .. " " .. getItemLabel(name) .. " ~c pour ~s $" .. price * quantity
                        })
                        limit[id] = new_limit
                    else
                        --[[TriggerClientEvent("core:ShowNotification", source, "~r~Tu as atteint la limite de 234 viandes par jour")]]
                        TriggerClientEvent("__vision::createNotification", source, {
                            type = 'ROUGE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "~s Tu as atteint la limite de 234 viandes par jour"
                        })
                    end
                else
                    --[[TriggerClientEvent("core:ShowNotification", source, "~r~Tu n'as pas assez de place dans ton inventaire")]]
                    TriggerClientEvent("__vision::createNotification", source, {
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Tu n'as pas assez de place dans ton inventaire"
                    })
                end
            else
                --[[TriggerClientEvent("core:ShowNotification", source, "~r~Tu n'as pas assez de " .. getItemLabel(name))]]
                TriggerClientEvent("__vision::createNotification", source, {
                    type = 'ROUGE',
                    -- duration = 5, -- In seconds, default:  4
                    content = "~s Tu n'as pas assez de " .. getItemLabel(name)
                })
            end
        end  
    end
end)

RegisterNetEvent("hunt:animalLock")
AddEventHandler("hunt:animalLock", function(animal)
    -- export the locked table to the client
    TriggerClientEvent("hunt:animalLock", -1, animal)
end)