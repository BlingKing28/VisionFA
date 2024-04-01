local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function GetVehicles()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

function GetClosestVehicle(coords)
	local vehicles = GetVehicles()
	local closestDistance = -1
	local closestVehicle = -1
	local playerPed = GetPlayerPed(-1)
	local coords = coords
	if coords == nil then
		coords = GetEntityCoords(playerPed)
	end

	for k, v in pairs(vehicles) do
		local vehicleCoords = GetEntityCoords(v)
		local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = v
			closestDistance = distance
		end
	end

	return closestVehicle, closestDistance
end

function GetClosestVehicleNoCoords()
	local vehicles = GetVehicles()
	local closestDistance = -1
	local closestVehicle = -1
	local playerPed = GetPlayerPed(-1)
	local coords = coords
	if coords == nil then
		coords = GetEntityCoords(playerPed)
	end

	for k, v in pairs(vehicles) do
		local vehicleCoords = GetEntityCoords(v)
		local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = v
			closestDistance = distance
		end
	end

	return closestVehicle, closestDistance
end

function GetClosestPlayer()
	local pPed = GetPlayerPed(-1)
	local players = GetActivePlayers()
	local coords = GetEntityCoords(pPed)
	local pCloset = nil
	local pClosetPos = nil
	local pClosetDst = nil
	for k, v in pairs(players) do
		if GetPlayerPed(v) ~= pPed then
			local oPed = GetPlayerPed(v)
			local oCoords = GetEntityCoords(oPed)
			local dst = GetDistanceBetweenCoords(oCoords, coords, true)
			if pCloset == nil then
				pCloset = v
				pClosetPos = oCoords
				pClosetDst = dst
			else
				if dst < pClosetDst then
					pCloset = v
					pClosetPos = oCoords
					pClosetDst = dst
				end
			end
		end
	end

	return pCloset, pClosetDst
end

function GetAllPlayersInArea(coords, zone)
	local playersInArea = {}
	if zone == nil then
		zone = 150.0
	end
	for k, v in pairs(GetActivePlayers()) do
		local pPed = GetPlayerPed(v)
		local pCoords = GetEntityCoords(pPed)
		if GetDistanceBetweenCoords(pCoords, coords, false) <= zone then
			table.insert(playersInArea, v)
		end
	end
	return playersInArea
end

function GetAllVehicleInArea(coords, zone)
	local playersInArea = {}
	if zone == nil then
		zone = 150.0
	end
	for k, v in pairs(GetVehicles()) do
		local pCoords = GetEntityCoords(v)
		if GetDistanceBetweenCoords(pCoords, coords, false) <= zone then
			table.insert(playersInArea, v)
		end
	end
	return playersInArea
end

function closeUI()
    SendNuiMessage(json.encode({
        type = 'closeWebview',
    }))
end

function ChoicePlayersInZone(range, choiceSelfPlayer)
	-- ShowNotification("Appuyer sur ~g~E~s~ pour valider\nAppuyer sur ~b~L~s~ pour changer de cible\nAppuyer sur ~r~X~s~ pour annuler")

	if choiceSelfPlayer == nil then
		choiceSelfPlayer = true
	end
	local timer = GetGameTimer() + 10000
	local inChoice = true
	local selectedPlayer = 1

	local players = GetAllPlayersInArea(p:pos(), range)
	if choiceSelfPlayer == false then
		for k, v in pairs(players) do
			if v == PlayerId() then
				table.remove(players, k)
			end
		end
	end
	if #players == 0 then
		-- New notif
		exports['vNotif']:createNotification({
			type = 'ROUGE',
			-- duration = 5, -- In seconds, default:  4
        	content = "~c Aucun joueur ~s dans la zone"
		})

		inChoice = false
		return nil
	else
		-- New notif
		exports['vNotif']:createNotification({
			type = 'VERT',
			duration = 10, -- In seconds, default:  4
			content = "Appuyer sur ~K E pour ~s valider"
		})
	
		exports['vNotif']:createNotification({
			type = 'JAUNE',
			duration = 10, -- In seconds, default:  4
			content = "Appuyer sur ~K L pour ~s changer de cible"
		})
			
		exports['vNotif']:createNotification({
			type = 'ROUGE',
			duration = 10, -- In seconds, default:  4
			content = "Appuyez sur ~K X pour ~s annuler"
		})
	end

	while inChoice do
		local players = GetAllPlayersInArea(p:pos(), range)
		if choiceSelfPlayer == false then
			for k, v in pairs(players) do
				if v == PlayerId() then
					table.remove(players, k)
				end
			end
		end
		if #players == 0 then
			-- ShowNotification("~r~Aucun joueur dans la zone")

			-- New notif
			exports['vNotif']:createNotification({
				type = 'ROUGE',
				-- duration = 5, -- In seconds, default:  4
        		content = "~c Aucun joueur ~s dans la zone"
			})

			inChoice = false
			return nil
		end
		local mCoors = GetEntityCoords(GetPlayerPed(players[selectedPlayer]))
		DrawMarker(20, mCoors.x, mCoors.y, mCoors.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255 , 120, 0, 1, 2, 0, nil, nil, 0)
		if GetGameTimer() > timer then
			-- ShowNotification("~r~Le délai est dépassé")

			-- New notif
			exports['vNotif']:createNotification({
				type = 'ROUGE',
				-- duration = 5, -- In seconds, default:  4
				content = "Le délai est dépassé"
			})
			inChoice = false
			return nil
		elseif IsControlJustPressed(0, 51) then -- E
			inChoice = false
			return players[selectedPlayer]
		elseif IsControlJustPressed(0, 182) then -- L
			timer = GetGameTimer() + 10000
			selectedPlayer = selectedPlayer + 1
		elseif IsControlJustPressed(0, 73) then -- X

			-- ShowNotification("~r~Vous avez annulé")
			
			-- New notif
			exports['vNotif']:createNotification({
				type = 'JAUNE',
				-- duration = 5, -- In seconds, default:  4
				content = "Vous avez ~s annulé"
			})

			inChoice = false
			return nil
		elseif selectedPlayer > #players then
			selectedPlayer = 1
		end
		Wait(0)
	end
end

function DisplayClosetVeh()
	local pCloset = GetClosestVehicle()
	if pCloset ~= -1 then
		local cCoords = GetEntityCoords(pCloset)
		DrawMarker(20, cCoords.x, cCoords.y, cCoords.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 0, 1
			, 2, 0, nil, nil, 0)
	end
end

function DisplayClosetPlayer()
	local pPed = GetPlayerPed(-1)
	local pCoords = GetEntityCoords(pPed)
	local pCloset = GetClosestPlayer()
	if pCloset ~= -1 then
		local cCoords = GetEntityCoords(GetPlayerPed(pCloset))
		DrawMarker(20, cCoords.x, cCoords.y, cCoords.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 0, 1
			, 2, 0, nil, nil, 0)
	end
end

GlobalBlockWeaponsKeys = false

function KeyboardImput(text)
	local amount = nil
	AddTextEntry("CUSTOM_AMOUNT", text)
	DisplayOnscreenKeyboard(1, "CUSTOM_AMOUNT", '', "", '', '', '', 255)
	GlobalBlockWeaponsKeys = true
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Wait(1)
	end
	GlobalBlockWeaponsKeys = false
	if UpdateOnscreenKeyboard() ~= 2 then
		amount = GetOnscreenKeyboardResult()
		Citizen.Wait(1)
	else
		Citizen.Wait(1)
	end
	return amount
end

function DrawText3D(coords, text, size, font)
	coords = vector3(coords.x, coords.y, coords.z)

	local camCoords = GetGameplayCamCoords()
	local distance = #(coords - camCoords)

	if not size then size = 1 end
	if not font then font = 0 end

	local scale = (size / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	SetTextScale(0.0 * scale, 0.55 * scale)
	SetTextFont(font)
	SetTextColour(255, 255, 255, 210)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	SetDrawOrigin(coords, 0)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

function LoadModel(model)
	local models
	if models == model then
		models = model
	else
		models =  GetHashKey(model)
	end

	if IsModelInCdimage(model) then
		RequestModel(model)
		while not HasModelLoaded(model) do Wait(1) end
	end
	SetModelAsNoLongerNeeded(model)
	return models
end

local function RotationToDirection(rotation)
	local adjustedRotation =
	{
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction =
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function RayCastGamePlayCamera(distance)
	local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =
	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x,
		destination.y, destination.z, 1, p:ped(), 1))
	return b, c, e
end

function RayCastGamePlayCameraEntity(distance)
	local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =
	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x,
		destination.y, destination.z, -1, p:ped(), 0))
	return b, c, e
end

function ShowNotification(text)
	text = text:gsub("^%l", string.upper)
	AddTextEntry('core:notif', text)
	BeginTextCommandThefeedPost('core:notif')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandThefeedPostTicker(true, true)
end

function ShowHelpNotification(msg, beep)
	local beep = beep
	if beep == nil then
		beep = false
	end
	AddTextEntry('core:HelpNotif', msg)
	BeginTextCommandDisplayHelp('core:HelpNotif')
	EndTextCommandDisplayHelp(0, false, false, 1)
end
exports("ShowNotification", function (msg)
	ShowNotification(msg)
end)
exports("ShowHelpNotification", function (msg)
	ShowHelpNotification(msg)
end)
function ShowAdvancedNotification(title, subtitle, msg, img1, img2)
	AddTextEntry('core:AdvancedNotif', msg)
	BeginTextCommandThefeedPost('core:AdvancedNotif')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandThefeedPostMessagetext(img1, img2, 1, 0, title, subtitle)
	EndTextCommandThefeedPostTicker(false, true)
end

function TeleportPlayer(coords)
	local pPed = PlayerPedId()
	local x, y, z = coords.x, coords.y, coords.z or coords.z + 1.0

	RequestCollisionAtCoord(x, y, z)
	NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)

	local sceneLoadTimer = GetGameTimer()
	while not IsNewLoadSceneLoaded() do
		if GetGameTimer() - sceneLoadTimer > 2000 then
			break
		end

		Citizen.Wait(0)
	end

	SetEntityCoordsNoOffset(pPed, x, y, z)
	sceneLoadTimer = GetGameTimer()

	while not HasCollisionLoadedAroundEntity(pPed) do
		if GetGameTimer() - sceneLoadTimer > 2000 then
			break
		end

		Citizen.Wait(0)
	end

	local foundNewZ, newZ = GetGroundZFor_3dCoord(x, y, z, 0, 0)
	if foundNewZ and newZ > 0 then
		z = newZ
	end

	SetEntityCoordsNoOffset(pPed, x, y, z)
	NewLoadSceneStop()

	return true
end

function Round(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10 ^ numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

-- credit http://richard.warburton.it
function GroupDigits(value)
	local left, num, right = string.match(value, '^([^%d]*%d)(%d*)(.-)$')

	return left .. (num:reverse():gsub('(%d%d%d)', '%1' .. _U('locale_digit_grouping_symbol')):reverse()) .. right
end

function Trim(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

function LoadDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do Wait(1) end
end

-- Events

RegisterNetEvent("core:ShowNotification")
AddEventHandler("core:ShowNotification", function(text)
	ShowNotification(text)
end)

RegisterNetEvent("core:ShowAdvancedNotification")
AddEventHandler("core:ShowAdvancedNotification", function(title, subtitle, msg, img1, img2)
	ShowAdvancedNotification(title, subtitle, msg, img1, img2)
end)

-- Loops

Citizen.CreateThread(function()
	LoadMpDlcMaps()
	SetInstancePriorityMode(true)
	OnEnterMp()
end)

local islandVec = vector3(4840.571, -5174.425, 2.0)
local isOnIsland = false
Citizen.CreateThread(function()
	while true do
		local pCoords = GetEntityCoords(GetPlayerPed(-1))
		local distance1 = #(pCoords - islandVec)
		if distance1 < 2000.0 then
			Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", true) -- load the map and removes the city
			Citizen.InvokeNative("0x5E1460624D194A38", true) -- load the minimap/pause map and removes the city minimap/pause map

			Citizen.InvokeNative(0xF74B1FFA4A15FBEA, true)
			Citizen.InvokeNative(0x53797676AD34A9AA, false)
			SetScenarioGroupEnabled('Heist_Island_Peds', true)

			SetAudioFlag('PlayerOnDLCHeist4Island', true)
			SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
			SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)
			SetZoneEnabled(59, false)
			isOnIsland = true

		else
			--if isOnIsland then
			Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", false)
			Citizen.InvokeNative("0x5E1460624D194A38", false)

			Citizen.InvokeNative(0xF74B1FFA4A15FBEA, false)
			Citizen.InvokeNative(0x53797676AD34A9AA, true)
			SetScenarioGroupEnabled('Heist_Island_Peds', false)

			SetAudioFlag('PlayerOnDLCHeist4Island', false)
			SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', false, false)
			SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', true, false)
			isOnIsland = false
			--end
		end
		Citizen.Wait(1000)
	end
end)

CreateThread(function()
	while p == nil do Wait(100) end
	while true do
		Wait(500)
		if p:isInVeh() then
			SetVehicleHandlingFloat(p:currentVeh(), "CHandlingData", "fLowSpeedTractionLossMult", 0.0)
		else
			Wait(1500)
		end
	end
end)

TriggerServerCallback = function(eventName, ...)
	assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got ' .. type(eventName))

	local p = promise.new()
	local ticket = GetGameTimer()

	RegisterNetEvent(('__pmc_callback:client:%s:%s'):format(eventName, ticket))
	local e = AddEventHandler(('__pmc_callback:client:%s:%s'):format(eventName, ticket), function(...)
		p:resolve({ ... })
	end)

	TriggerServerEvent('__pmc_callback:server', eventName, ticket, ...)

	local result = Citizen.Await(p)
	RemoveEventHandler(e)
	return table.unpack(result)
end
exports("TriggerServerCallback", function(eventName, ...)
	return TriggerServerCallback(eventName, ...)
end)
RegisterClientCallback = function(eventName, fn, ...)
	assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got ' .. type(eventName))
	assert(type(fn) == 'function', 'Invalid Lua type at argument #2, expected function, got ' .. type(fn))

	AddEventHandler(('c__pmc_callback:%s'):format(eventName), function(cb, ...)
		cb(fn(...))
	end)
end

RegisterNetEvent('__pmc_callback:client')
AddEventHandler('__pmc_callback:client', function(eventName, ...)
	local p = promise.new()

	TriggerEvent(('c__pmc_callback:%s'):format(eventName), function(...)
		p:resolve({ ... })
	end, ...)

	local result = Citizen.Await(p)
	TriggerServerEvent(('__pmc_callback:server:%s'):format(eventName), table.unpack(result))
end)

function RequestAndWaitDict(dictName)
	if dictName and DoesAnimDictExist(dictName) and not HasAnimDictLoaded(dictName) then
		RequestAnimDict(dictName)
		while not HasAnimDictLoaded(dictName) do Citizen.Wait(100) end
	end
end

function DrawTexts(x, y, text, center, scale, rgb, font)
	SetTextFont(font)
	SetTextScale(scale, scale)

	SetTextColour(rgb[1], rgb[2], rgb[3], rgb[4])
	SetTextEntry("STRING")
	SetTextCentre(center)
	AddTextComponentString(text)
	EndTextCommandDisplayText(x, y)
end

function PlayEmote(dict, anim, flag, duration)
	--[[
		FLAGS
		0 = NORMAL
		1 = REPEAT
		2 = STOP LAST FRAME
		16 = UPPERBODY
		32 = ENABLE PLAYER CONTROL
		120 = CANCELABLE
	]]
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do Wait(1) end
	TaskPlayAnim(GetPlayerPed(-1), dict, anim, 1.0, 1.0, duration, flag or 32, 1.0, 0, 0, 0)
	RemoveAnimDict(dict)
end

----loadStreamTexture

-- function LoadStreamTexture()
-- 	local Texture = {"4life","ui_market", "ui_concess", "ui_autoecole", "ui_armurerie"}
-- 	Citizen.CreateThread(function()
-- 		for k,v in pairs(Texture) do while not HasStreamedTextureDictLoaded(v)  do Wait(100) RequestStreamedTextureDict(v, true) print(v) end end
-- 	end)
-- end

-- LoadStreamTexture()


-- function isMouseOnButton(position, buttonPos, widthandheight)

-- 	return position.x >= buttonPos.x and position.y >= buttonPos.y and position.x < buttonPos.x + widthandheight.width and position.y < buttonPos.y + widthandheight.height

-- end


function LoadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Wait(0)
	end
end

function SecondsToClock(ms)
	local seconds = math.floor(ms / 1000)
	local mseconds = math.fmod(ms, 1000);

	if seconds <= 0 then
		return "00:00:00";
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600));
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)));
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60));
		local msecs = string.format("%02.f", math.floor(mseconds));
		return mins, secs, msecs
	end
end

--[[local function getEntityMatrix(element)
    local rot = GetEntityRotation(element) -- ZXY
    local rx, ry, rz = rot.x, rot.y, rot.z
    rx, ry, rz = math.rad(rx), math.rad(ry), math.rad(rz)
    local matrix = {}
    matrix[1] = {}
    matrix[1][1] = math.cos(rz)*math.cos(ry) - math.sin(rz)*math.sin(rx)*math.sin(ry)
    matrix[1][2] = math.cos(ry)*math.sin(rz) + math.cos(rz)*math.sin(rx)*math.sin(ry)
    matrix[1][3] = -math.cos(rx)*math.sin(ry)
    matrix[1][4] = 1
    
    matrix[2] = {}
    matrix[2][1] = -math.cos(rx)*math.sin(rz)
    matrix[2][2] = math.cos(rz)*math.cos(rx)
    matrix[2][3] = math.sin(rx)
    matrix[2][4] = 1
	
    matrix[3] = {}
    matrix[3][1] = math.cos(rz)*math.sin(ry) + math.cos(ry)*math.sin(rz)*math.sin(rx)
    matrix[3][2] = math.sin(rz)*math.sin(ry) - math.cos(rz)*math.cos(ry)*math.sin(rx)
    matrix[3][3] = math.cos(rx)*math.cos(ry)
    matrix[3][4] = 1
	
    matrix[4] = {}
    local pos = GetEntityCoords(element)
    matrix[4][1], matrix[4][2], matrix[4][3] = pos.x, pos.y, pos.z - 1.0
    matrix[4][4] = 1
	
    return matrix
end

function GetOffsetFromEntityInWorldCoords(entity, offX, offY, offZ)
    local m = getEntityMatrix(entity)
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return vector3(x, y, z)
end
]]
function RealRandom(x, y)
	math.randomseed(GetGameTimer())
	return math.random(x, y)
end

function CompareMetadatas(t1, t2)
    -- Compare each entry of table t1 with the same entry of table t2
    -- If entry is a table, recursively call this function
    -- If t1 entry is not the same as t2 entry, return false
    -- If tables are not exactly the same, return false

    if type(t1) ~= "table" or type(t2) ~= "table" then
        return false
    end

    for k,v in pairs(t1) do
        if type(v) == "table" then
            if not CompareMetadatas(v, t2[k]) then
                return false
            end
        else
			print(v, t2[k])
            if v ~= t2[k] then
                return false
            end
        end
    end
	return true
end
