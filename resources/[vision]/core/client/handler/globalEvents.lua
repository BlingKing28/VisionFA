RegisterNetEvent("core:OpenVehicleTruck")
AddEventHandler("core:OpenVehicleTruck", function(net)
    local vehicle = NetworkGetEntityFromNetworkId(net)
    SetVehicleDoorOpen(vehicle, 5, false, false)
end)

RegisterNetEvent("core:CloseVehicleTruck")
AddEventHandler("core:CloseVehicleTruck", function(net)
    local vehicle = NetworkGetEntityFromNetworkId(net)
    SetVehicleDoorShut(vehicle, 5, false)
end)