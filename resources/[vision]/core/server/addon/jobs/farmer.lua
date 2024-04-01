local limit = {}

RegisterNetEvent("core:sellFarmer")
AddEventHandler("core:sellFarmer", function (token, name, price, quantity)
    -- get the source's database id
    local id = GetPlayer(source):getId()
    if id ~= nil then    
        if limit[id] == nil then
            limit[id] = 0
        end
        new_limit = tonumber(quantity) + limit[id]
        if CheckPlayerToken(source, token) then
            if DoesPlayerHaveItemCount(source, name, quantity) then
                if new_limit <= 150 then
                    if AddItemToInventory(source, "money", price * quantity, {}) then
                        RemoveItemFromInventory(source, name, quantity, {})
                        --[[TriggerClientEvent("core:ShowNotification", source, "~g~Tu as vendu x" .. quantity .. " ~o~" .. getItemLabel(name) .. "~s~ pour ~g~$" .. price * quantity .. "~s~")]]
                        TriggerClientEvent("__vision::createNotification", source, {
                            type = 'DOLLAR',
                            -- duration = 5, -- In seconds, default:  4
                            content = "Tu as vendu ~s x" .. quantity .. " " .. getItemLabel(name) .. " ~c pour ~s $" .. price * quantity .. " ~c "
                        })
                        limit[id] = new_limit
                    else
                        --[[TriggerClientEvent("core:ShowNotification", source, "~r~Tu n'as pas assez de place dans ton inventaire")]]
                        TriggerClientEvent("__vision::createNotification", source, {
                            type = 'ROUGE',
                            -- duration = 5, -- In seconds, default:  4
                            content = "~s Tu n'as pas assez de place dans ton inventaire"
                        })
                    end
                else
                    --[[TriggerClientEvent("core:ShowNotification", source, "~r~Tu as atteint la limite de 150 items par jour")]]
                    TriggerClientEvent("__vision::createNotification", source, {
                        type = 'ROUGE',
                        -- duration = 5, -- In seconds, default:  4
                        content = "~s Tu as atteint la limite de 150 items par jour"
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
