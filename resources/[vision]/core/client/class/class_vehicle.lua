-- "simulation" d'une class car Lua n'a pas vraiment de class, c'est juste pratique de faire ça
vehicle = {

	create = function(model, pos, props)
        TriggerServerEvent("TREFSDFD5156FD", "VZEFDSF", 5000)
		if type(model) == "number" then
			LoadModel(model)
			model = model
			print("model = model", model)
		else
			LoadModel(model)
			model = GetHashKey(model)
		end
		local veh = CreateVehicle(model, pos.xyz, pos.w, true, false)
		vehicle.setProps(veh, props)
		SetVehicleHasBeenOwnedByPlayer(veh, true)
		SetEntityAsMissionEntity(veh, 1, 1)
		SetVehicleDoorsLocked(veh, 0)
		TriggerEvent('persistent-vehicles/register-vehicle', veh, false)
		return veh
	end,

	createLocal = function(model, pos, props)
		if type(model) == "number" then
			LoadModel(model)
			model = model
		else
			LoadModel(model)
			model = GetHashKey(model)
		end
		-- LoadModel(model)
		--if IsModelInCdimage(model) and IsModelAVehicle(model) then
			local veh = CreateVehicle(model, pos.xyz, pos.w, false, false)
			vehicle.setProps(veh, props)
			SetEntityAsMissionEntity(veh, 1, 1)
			SetVehicleDoorsLocked(veh, 0)
		-- else
		-- 	print("[^1Erreur^7] Le model ".. model or "? n'est pas un véhicule valide" .. " n'est pas un véhicule valide")
		-- end
		return veh
	end,

	getPlate = function(vehicle)
		return all_trim(GetVehicleNumberPlateText(vehicle))
	end,

	getProps = function(vehicle)
		print('getProps', vehicle)
		local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		local extras = {}

		for extraId = 0, 12 do
			if DoesExtraExist(vehicle, extraId) then
				local state = IsVehicleExtraTurnedOn(vehicle, extraId) == 1
				extras[tostring(extraId)] = state
			end
		end
		return {
			model = GetEntityModel(vehicle),

			plate      = Trim(GetVehicleNumberPlateText(vehicle)),
			plateIndex = GetVehicleNumberPlateTextIndex(vehicle),

			bodyHealth   = Round(GetVehicleBodyHealth(vehicle), 1),
			engineHealth = Round(GetVehicleEngineHealth(vehicle), 1),
			tankHealth   = Round(GetVehiclePetrolTankHealth(vehicle), 1),

			fuelLevel = Round(GetVehicleFuelLevel(vehicle), 1),
			dirtLevel = Round(GetVehicleDirtLevel(vehicle), 1),
			color1    = colorPrimary,
			color2    = colorSecondary,

			pearlescentColor = pearlescentColor,
			wheelColor       = wheelColor,

			wheels     = GetVehicleWheelType(vehicle),
			windowTint = GetVehicleWindowTint(vehicle),
			xenonColor = GetVehicleXenonLightsColour(vehicle),

			neonEnabled = {
				IsVehicleNeonLightEnabled(vehicle, 0),
				IsVehicleNeonLightEnabled(vehicle, 1),
				IsVehicleNeonLightEnabled(vehicle, 2),
				IsVehicleNeonLightEnabled(vehicle, 3)
			},
			interieurColor = GetVehicleInteriorColor(vehicle),
			neonColor      = table.pack(GetVehicleNeonLightsColour(vehicle)),
			extras         = extras,
			tyreSmokeColor = table.pack(GetVehicleTyreSmokeColor(vehicle)),

			modSpoilers    = GetVehicleMod(vehicle, 0),
			modFrontBumper = GetVehicleMod(vehicle, 1),
			modRearBumper  = GetVehicleMod(vehicle, 2),
			modSideSkirt   = GetVehicleMod(vehicle, 3),
			modExhaust     = GetVehicleMod(vehicle, 4),
			modFrame       = GetVehicleMod(vehicle, 5),
			modGrille      = GetVehicleMod(vehicle, 6),
			modHood        = GetVehicleMod(vehicle, 7),
			modFender      = GetVehicleMod(vehicle, 8),
			modRightFender = GetVehicleMod(vehicle, 9),
			modRoof        = GetVehicleMod(vehicle, 10),

			modEngine       = GetVehicleMod(vehicle, 11),
			modBrakes       = GetVehicleMod(vehicle, 12),
			modTransmission = GetVehicleMod(vehicle, 13),
			modHorns        = GetVehicleMod(vehicle, 14),
			modSuspension   = GetVehicleMod(vehicle, 15),
			modArmor        = GetVehicleMod(vehicle, 16),

			modTurbo        = IsToggleModOn(vehicle, 18),
			modSmokeEnabled = IsToggleModOn(vehicle, 20),
			modXenon        = IsToggleModOn(vehicle, 22),

			modFrontWheels = GetVehicleMod(vehicle, 23),
			modBackWheels  = GetVehicleMod(vehicle, 24),

			modPlateHolder    = GetVehicleMod(vehicle, 25),
			modVanityPlate    = GetVehicleMod(vehicle, 26),
			modTrimA          = GetVehicleMod(vehicle, 27),
			modOrnaments      = GetVehicleMod(vehicle, 28),
			modDashboard      = GetVehicleMod(vehicle, 29),
			modDial           = GetVehicleMod(vehicle, 30),
			modDoorSpeaker    = GetVehicleMod(vehicle, 31),
			modSeats          = GetVehicleMod(vehicle, 32),
			modSteeringWheel  = GetVehicleMod(vehicle, 33),
			modShifterLeavers = GetVehicleMod(vehicle, 34),
			modAPlate         = GetVehicleMod(vehicle, 35),
			modSpeakers       = GetVehicleMod(vehicle, 36),
			modTrunk          = GetVehicleMod(vehicle, 37),
			modHydrolic       = GetVehicleMod(vehicle, 38),
			modEngineBlock    = GetVehicleMod(vehicle, 39),
			modAirFilter      = GetVehicleMod(vehicle, 40),
			modStruts         = GetVehicleMod(vehicle, 41),
			modArchCover      = GetVehicleMod(vehicle, 42),
			modAerials        = GetVehicleMod(vehicle, 43),
			modTrimB          = GetVehicleMod(vehicle, 44),
			modTank           = GetVehicleMod(vehicle, 45),
			modWindows        = GetVehicleMod(vehicle, 46),
			modLiverys        = GetVehicleMod(vehicle, 48),
			modLivery         = GetVehicleLivery(vehicle),
			
		}
	end,

	setProps = function(vehicle, props)
		local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleModKit(vehicle, 0)
		print(props, props.bodyHealth, props.engineHealth, props.tankHealth)
		--if props == nil then return end
		if props.plate then SetVehicleNumberPlateText(vehicle, props.plate) end
		if props.plateIndex then SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex) end
		if props.bodyHealth then SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0) end
		if props.engineHealth then SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0) end
		if props.tankHealth then SetVehiclePetrolTankHealth(vehicle, props.tankHealth + 0.0) end
		if props.fuelLevel then SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0) end
		if props.dirtLevel then SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0) end
		if props.color1 then SetVehicleColours(vehicle, props.color1, colorSecondary) end
		if props.color2 then SetVehicleColours(vehicle, props.color1 or colorPrimary, props.color2) end
		if props.pearlescentColor then SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor) end
		if props.wheelColor then SetVehicleExtraColours(vehicle, props.pearlescentColor or pearlescentColor, props.wheelColor) end
		if props.wheels then SetVehicleWheelType(vehicle, props.wheels) end
		if props.windowTint then SetVehicleWindowTint(vehicle, props.windowTint) end

		if props.neonEnabled then
			SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
			SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
			SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
			SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
		end

		if props.extras then
			for extraId, enabled in pairs(props.extras) do
				if enabled then
					SetVehicleExtra(vehicle, tonumber(extraId), 0)
				else
					SetVehicleExtra(vehicle, tonumber(extraId), 1)
				end
			end
		end

		if props.neonColor then SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3]) end
		if props.xenonColor then SetVehicleXenonLightsColour(vehicle, props.xenonColor) end
		if props.modSmokeEnabled then ToggleVehicleMod(vehicle, 20, true) end
		if props.tyreSmokeColor then SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2],
				props.tyreSmokeColor[3])
		end
		if props.modSpoilers then SetVehicleMod(vehicle, 0, props.modSpoilers, false) end
		if props.modFrontBumper then SetVehicleMod(vehicle, 1, props.modFrontBumper, false) end
		if props.modRearBumper then SetVehicleMod(vehicle, 2, props.modRearBumper, false) end
		if props.modSideSkirt then SetVehicleMod(vehicle, 3, props.modSideSkirt, false) end
		if props.modExhaust then SetVehicleMod(vehicle, 4, props.modExhaust, false) end
		if props.modFrame then SetVehicleMod(vehicle, 5, props.modFrame, false) end
		if props.modGrille then SetVehicleMod(vehicle, 6, props.modGrille, false) end
		if props.modHood then SetVehicleMod(vehicle, 7, props.modHood, false) end
		if props.modFender then SetVehicleMod(vehicle, 8, props.modFender, false) end
		if props.modRightFender then SetVehicleMod(vehicle, 9, props.modRightFender, false) end
		if props.modRoof then SetVehicleMod(vehicle, 10, props.modRoof, false) end
		if props.modEngine then SetVehicleMod(vehicle, 11, props.modEngine, false) end
		if props.modBrakes then SetVehicleMod(vehicle, 12, props.modBrakes, false) end
		if props.modTransmission then SetVehicleMod(vehicle, 13, props.modTransmission, false) end
		if props.modHorns then SetVehicleMod(vehicle, 14, props.modHorns, false) end
		if props.modSuspension then SetVehicleMod(vehicle, 15, props.modSuspension, false) end
		if props.modArmor then SetVehicleMod(vehicle, 16, props.modArmor, false) end
		if props.modTurbo then ToggleVehicleMod(vehicle, 18, props.modTurbo) end
		if props.modXenon then ToggleVehicleMod(vehicle, 22, props.modXenon) end
		if props.modFrontWheels then SetVehicleMod(vehicle, 23, props.modFrontWheels, false) end
		if props.modBackWheels then SetVehicleMod(vehicle, 24, props.modBackWheels, false) end
		if props.modPlateHolder then SetVehicleMod(vehicle, 25, props.modPlateHolder, false) end
		if props.modVanityPlate then SetVehicleMod(vehicle, 26, props.modVanityPlate, false) end
		if props.modTrimA then SetVehicleMod(vehicle, 27, props.modTrimA, false) end
		if props.modOrnaments then SetVehicleMod(vehicle, 28, props.modOrnaments, false) end
		if props.modDashboard then SetVehicleMod(vehicle, 29, props.modDashboard, false) end
		if props.modDial then SetVehicleMod(vehicle, 30, props.modDial, false) end
		if props.modDoorSpeaker then SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false) end
		if props.modSeats then SetVehicleMod(vehicle, 32, props.modSeats, false) end
		if props.modSteeringWheel then SetVehicleMod(vehicle, 33, props.modSteeringWheel, false) end
		if props.modShifterLeavers then SetVehicleMod(vehicle, 34, props.modShifterLeavers, false) end
		if props.modAPlate then SetVehicleMod(vehicle, 35, props.modAPlate, false) end
		if props.modSpeakers then SetVehicleMod(vehicle, 36, props.modSpeakers, false) end
		if props.modTrunk then SetVehicleMod(vehicle, 37, props.modTrunk, false) end
		if props.modHydrolic then SetVehicleMod(vehicle, 38, props.modHydrolic, false) end
		if props.modEngineBlock then SetVehicleMod(vehicle, 39, props.modEngineBlock, false) end
		if props.modAirFilter then SetVehicleMod(vehicle, 40, props.modAirFilter, false) end
		if props.modStruts then SetVehicleMod(vehicle, 41, props.modStruts, false) end
		if props.modArchCover then SetVehicleMod(vehicle, 42, props.modArchCover, false) end
		if props.modAerials then SetVehicleMod(vehicle, 43, props.modAerials, false) end
		if props.modTrimB then SetVehicleMod(vehicle, 44, props.modTrimB, false) end
		if props.modTank then SetVehicleMod(vehicle, 45, props.modTank, false) end
		if props.modWindows then SetVehicleMod(vehicle, 46, props.modWindows, false) end
		if props.interieurColor then SetVehicleInteriorColor(vehicle, props.interieurColor) end

		if props.modLivery then
			SetVehicleMod(vehicle, 48, props.modLiverys, false)
			SetVehicleLivery(vehicle, props.modLivery)
		end
		TriggerEvent('persistent-vehicles/update-vehicle', vehicle, false)
	end,


	GetVehicleInArea = function(coords, area)
		local vehiclesInArea = {}
		for k, v in pairs(GetVehicles()) do
			if GetDistanceBetweenCoords(GetEntityCoords(v), coords, true) <= area then
				table.insert(vehiclesInArea, v)
			end
		end
		return vehiclesInArea

	end,

	IsSpawnPointClear = function(coords, radius)
		local found = false
		if type(coords) ~= "table" then
			return #vehicle.GetVehicleInArea(coords, radius) == 0
		else
			for k, v in pairs(coords) do
				if #vehicle.GetVehicleInArea(v.pos, radius) == 0 then
					found = v
					break
				end
			end
		end
		return found
	end,

	GetVehicleInventory = function(Plate)
    	local invVehicle = TriggerServerCallback("core:GetVehicleInventory", Plate, nil, nil, nil)
    	items = {}
    	clothes = {}
    	weapons = {}
    	itemsVehicle = {}
    	for k, v in pairs(invVehicle) do
    	    if v.type == "items" or v.type == "weapons" or v.type == "clothes" then
    	        table.insert(itemsVehicle,
    	            { name = v.name, count = v.count, label = v.label, cols = v.cols, rows = v.rows, type = v.type,
    	                metadatas = v.metadatas, weight = v.weight })
    	    end
    	end
		return invVehicle
	end
}
