local leftActive = false
local rightActive = false
local hazardActive = false

CreateThread(function()
    while true do
		if IsPedInAnyVehicle(PlayerPedId(), true) then
			if IsControlJustPressed(1, 174) then 
				local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
				hazardActive = false
				rightActive = false
				leftActive = not leftActive
				SetVehicleIndicatorLights(vehicle, 1, leftActive)
				SetVehicleIndicatorLights(vehicle, 0, false)
			end
			if IsControlJustPressed(1, 175) then 
				local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
				rightActive = not rightActive
				hazardActive = false		
				leftActive = false
				SetVehicleIndicatorLights(vehicle, 0, rightActive)
				SetVehicleIndicatorLights(vehicle, 1, false)
			end
			if IsControlJustPressed(1, 173) then
				local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
				leftActive = false
				rightActive = false
				hazardActive = not hazardActive
				SetVehicleIndicatorLights(vehicle, 0, hazardActive)
				SetVehicleIndicatorLights(vehicle, 1, hazardActive)
			end
			Wait(1)
		else
			Wait(1000)
		end
    end
end)

