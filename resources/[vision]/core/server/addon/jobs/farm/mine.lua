RegisterNetEvent('mine:removeMinerai', function(plate, item, count)
    local index = GetVehicleIndexFromPlate(plate)
    RemoveItemToVehicle(index, plate, item, count, {})
end)