RegisterNetEvent("core:ChangeDoorState")
AddEventHandler("core:ChangeDoorState", function(token, door, state)
    if CheckPlayerToken(source, token) then
        TriggerClientEvent("core:ChangeDoorState", -1, door, state)
    else
        -- TODO: Ac detection
    end
end)