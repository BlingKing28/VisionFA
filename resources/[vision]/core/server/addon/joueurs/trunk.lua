RegisterNetEvent("core:putInTrunk")
AddEventHandler("core:putInTrunk", function(entity, vehicle)
    TriggerClientEvent("core:putInTrunk", entity, vehicle)
end)

RegisterNetEvent("core:emptyTrunk")
AddEventHandler("core:emptyTrunk", function(entity, vehicle)
    TriggerClientEvent("core:emptyTrunk2", entity)
end)