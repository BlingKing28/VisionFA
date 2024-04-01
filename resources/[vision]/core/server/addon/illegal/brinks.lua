RegisterNetEvent("brinksSendStart", function(netVeh)
    TriggerClientEvent("brinksStartAttack", -1, netVeh)
end)