local DecorationsProperty = {}
local LoadedProperty = {}
local PlacedProps = {}

local function IsCoOwnerDeco(source, property)
    local player = GetPlayer(source)
	local coowners = GetProperty(property):_co_owner()
	local crew = GetProperty(property):_crew()
	if crew and crew == player:getJob() then
        return true
    end
    if crew and crew == player:getCrew() then
        return true
    end
    if coowners then
		if type(coowners) == "table" then
			for k, v in pairs(coowners) do
				if tonumber(v.id) == player:getId() then
					return true
				end
			end
		else
			return coowners == player:getId()
		end
    end
    return false
end

local function CountPlayerInProperty(propertyId)
	local count = 0
	for _ in pairs(PlayersInHouse[propertyId]) do
		count = count + 1
	end
	return tonumber(count)
end

RegisterNetEvent('core:updateDecorationProperty', function(token, decorationsList, propertyId)
	local source = source
	local id = GetPlayer(source):getId()
	if CheckPlayerToken(source, token) then
		local formatedData = {}
		for _, data in pairs(decorationsList) do
			table.insert(formatedData, {
				prop = data.prop,
				heading = data.heading,
				coords = data.coords
			})
		end
		if DecorationsProperty[propertyId] == nil then
			DecorationsProperty[propertyId] = {}
		end
		DecorationsProperty[propertyId] = decorationsList
		--   OLD
		--MySQL.Async.execute("UPDATE property_decoration SET decorations = @decorations WHERE property = @id", {
		--	["@decorations"] = json.encode(formatedData),
		--	["@id"] = tonumber(propertyId)
		--}, function(result)
		--	if result then
		--		-- end.
		--	end
		--end)
		--   NEW
		MySQL.Async.execute("UPDATE property SET decoration=@decoration WHERE id=@id", {
			["@id"] = tonumber(propertyId),
			["@decoration"] = json.encode(formatedData),
		}, function(result)
			if result then 
				TriggerClientEvent('__vision::createNotification', source, {
					type = 'VERT',
					content = "La décoration de votre appartement a été sauvegardée."
				})
			end
		end)
	end
end)

RegisterNetEvent('core:leaveDecorationProperty', function(token, propertyData, flag)
	local src = source
	local playerId = GetPlayer(src):getId()
	if CheckPlayerToken(src, token) then
		if tonumber(propertyData.owner) == playerId or IsCoOwnerDeco(src, propertyData) then
			TriggerClientEvent('core:useDecorationProperty', src, propertyData, false)
		end
		--if CountPlayerInProperty(propertyData.id) <= 0 then
		--	TriggerClientEvent('core:unloadDecorationProperty', src)
		--	DecorationsProperty[propertyData.id] = nil
		--end
	end
end)

CreateThread(function()
	while not MySQL do Wait(1) end 
	Wait(1000)
	local result = MySQL.Sync.fetchAll("SELECT id, decoration FROM property", {})
	if not result then return end
	for k,v in pairs(result) do 
		if v.decoration then
			DecorationsProperty[v.id] = {}
			local deco = json.decode(v.decoration)
			for i,p in ipairs(deco) do 
				table.insert(DecorationsProperty[v.id], {
					prop = p.prop,
					coords = p.coords,
					heading = p.heading
				})
			end
			CorePrint("Created interior for property id " .. v.id .. ".")
		end
	end
end)

RegisterNetEvent('core:enterDecorationProperty', function(token, propertyData, flag)
	local src = source
	local found = false
	local playerId = GetPlayer(src):getId()
	if CheckPlayerToken(src, token) then
		if string.find(propertyData.data.interior, "Vide") then
			if tonumber(propertyData.owner) == playerId or IsCoOwnerDeco(src, propertyData) then
				TriggerClientEvent('core:useDecorationProperty', src, propertyData, true)
			end
			if LoadedProperty[propertyData.id] == nil then -- is loaded ?
				LoadedProperty[propertyData.id] = true
				TriggerClientEvent('core:loadDecorationProperty', src, DecorationsProperty[propertyData.id]) -- laod it
			end
			TriggerClientEvent('core:getDeco', src, DecorationsProperty[propertyData.id])
		end
	end
end)

RegisterNetEvent("core:deco:instanceobject", function(netid, coords, propid)
	local _source = source
	local entity = NetworkGetEntityFromNetworkId(netid)
	SetEntityRoutingBucket(entity, GetPlayerRoutingBucket(_source))
	local found = false
	if next(PlacedProps) then
		for k,v in pairs(PlacedProps) do 
			if v.propertyId == propid then 
				found = true
				table.insert(v.props, {entity = entity, coords = coords})
			end
		end
	end
	if not found then 
		table.insert(PlacedProps, {propertyId = propid, props = {{entity = entity, coords = coords}}})
	end
end)

RegisterServerCallback("core:deco:getInstancedObjects", function(source, propid)
	local found = 1
	for k,v in pairs(PlacedProps) do 
		if v.propertyId == tonumber(propid) then 
			found = v.props
		end
	end
	Wait(100)
	return found
end)