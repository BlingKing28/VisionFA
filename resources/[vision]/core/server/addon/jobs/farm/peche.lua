local limit = {}

RegisterNetEvent("core:SellPecheur")
AddEventHandler("core:SellPecheur", function (token, item, count, price)
    local source = source
    local sold = false
    if CheckPlayerToken(source, token) then
        for k, v in pairs(GetPlayer(source):getInventaire()) do
            if v.name == item then
                if RemoveItemFromInventory(source, item, count, v.metadatas) then
                    for key, value in pairs(GetPlayer(source):getInventaire()) do
                        if value.name == "money" then 
                            AddItemToInventory(source, "money", price, value.metadatas)
                            --[[TriggerClientEvent("core:ShowNotification", source, "Vous avez vendu un(e) " ..item.. " pour ~g~"..price.."$")]]
                            --[[ TriggerClientEvent("__vision::createNotification", source, {
                                type = 'DOLLAR',
                                -- duration = 5, -- In seconds, default:  4
                                content = "Vous avez vendu un(e) ~s " ..item.. " ~c pour ~s "..price.."$"
                            }) ]]
                            sold = true
                            return
                        end
                    end
                    if not sold then
                        AddItemToInventory(source, "money", price, {})
                        sold = true
                    end
                end
            end
        end
    end
end)

CreateThread(function ()
    while RegisterServerCallback == nil do Wait(0) end

    RegisterServerCallback("core:addJournalier", function (source)
        local id = GetPlayer(source):getId()
        if limit[id] == nil then
            limit[id] = 1
        else
            limit[id] = limit[id] + 1
        end
        return limit[id]
    end)
end)