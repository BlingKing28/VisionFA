RegisterNetEvent("core:pawnshopSell")
AddEventHandler("core:pawnshopSell", function(token, item, price)
    local source = source
    if CheckPlayerToken(source, token) then
        if DoesPlayerHaveItemCount(source, item, 1) then
            AddMoneyToSociety(price, "pawnshop")
            print(price, item, source)
            RemoveItemFromInventory(source, item, 1, {})
            TriggerClientEvent("__vision::createNotification", source, {
                type = 'JAUNE',
                -- duration = 5, -- In seconds, default:  4
                content = "Vous avez vendu ~s" .. getItemLabel(item)
            })
        else
            TriggerClientEvent("__vision::createNotification", source, {
                type = 'ROUGE',
                -- duration = 5, -- In seconds, default:  4
                content = "Tu n'as pas assez de place ~s" .. getItemLabel(item)
            })
        end
    end
end)