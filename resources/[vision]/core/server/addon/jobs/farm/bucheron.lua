RegisterNetEvent('bucheron:removeWood', function(plate, rawwoodCount)
    local index = GetVehicleIndexFromPlate(plate)
    RemoveItemToVehicle(index, plate, "rawwood", rawwoodCount, {})
end)