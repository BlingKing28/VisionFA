RegisterNetEvent("core:createCrewCreation")
AddEventHandler("core:createCrewCreation", function(playerId)
    TriggerClientEvent("core:createCrewCreation", playerId)
end)
