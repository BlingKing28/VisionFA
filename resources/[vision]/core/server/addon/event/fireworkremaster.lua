RegisterNetEvent('firework:ServerStart', function(ppos)
    TriggerClientEvent('firework:ClientStart', -1, ppos)
end)

RegisterNetEvent('firework:STOP', function()
    TriggerClientEvent('firework:STOPcl', -1)
end)