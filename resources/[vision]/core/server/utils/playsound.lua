RegisterNetEvent('serverPlaySound', function(url,volume)
    TriggerClientEvent('clientPlaySound', -1, url, volume)
end)

RegisterNetEvent('serverStopSound', function()
    TriggerClientEvent('clientStopSound', -1)
end)

RegisterNetEvent('serverVolumeSound', function(volume)
    TriggerClientEvent('clientVolumeSound', -1, volume)
end)