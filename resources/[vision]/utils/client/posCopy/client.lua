-- copy coords command
RegisterCommand('co', function(source, args, rawCommand)
	local coords = GetEntityCoords(PlayerPedId())
	local heading = GetEntityHeading(PlayerPedId())
	local z = coords.z-1
	print(coords.x..", "..coords.y..", "..z)
	SendNUIMessage({
		coords = coords.x..", "..coords.y..", "..z
	})
end)

RegisterCommand('coh', function(source, args, rawCommand)
	local coords = GetEntityCoords(PlayerPedId())
	local heading = GetEntityHeading(PlayerPedId())
	local z = coords.z-1
	print(coords.x..", "..coords.y..", "..z..", "..heading)
	SendNUIMessage({
		coords = coords.x..", "..coords.y..", "..z..", "..heading
	})
end)

AddEventHandler("addToCopy", function(...)
	SendNUIMessage({
		coords = ...
	})
end)