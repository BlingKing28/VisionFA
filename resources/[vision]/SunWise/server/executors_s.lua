local serverRes = {}
local ResourceMetadata = {}
local ResourceFiles = {}
local FoundCheaters = {}

AddEventHandler('onResourceStop', function(res)
    for k,v in pairs(serverRes) do 
        if v.resource == res then 
            table.remove(serverRes, k)
        end
    end
end)

AddEventHandler('onResourceStart', function(res)
    table.insert(serverRes, {resource = res})
end)

local logged = false
local function existInTable(res)
    ignoreBool = false 
    for k,v in pairs(serverRes) do 
        if v.resource == res then 
            ignoreBool = true 
        end
    end
	if res == "_cfx_internal" then 
		ignoreBool = true
	end
	if not ResourceMetadata[res] then
		local start = GetResourceState(res)
		if start == "started" or start == "starting" or start == "stopped" then 
			for i = 0, GetNumResourceMetadata(res, 'client_script') do
				local typer = GetResourceMetadata(res, 'client_script', i)
				local fileee = LoadResourceFile(tostring(res), tostring(typer))
				if ResourceMetadata[res] == nil then
					ResourceMetadata[res] = {}
				end
				if ResourceFiles[res] == nil then
					ResourceFiles[res] = {}
				end
				if typer ~= nil then
					logged = true
					table.insert(ResourceMetadata[res], #typer)
				end
				if fileee ~= nil then
					table.insert(ResourceFiles[res], #fileee)
				end
			end
			for i = 0, GetNumResourceMetadata(res, 'client_scripts') do
				local typere = GetResourceMetadata(res, 'client_scripts', i)
				local filez = LoadResourceFile(tostring(res), tostring(typere))
				if ResourceMetadata[res] == nil then
					ResourceMetadata[res] = {}
				end
				if ResourceFiles[res] == nil then
					ResourceFiles[res] = {}
				end
				if typere ~= nil then
					logged = true
					table.insert(ResourceMetadata[res], #typere)
				end
				if filez ~= nil then
					table.insert(ResourceFiles[res], #filez)
				end
			end
			for i = 0, GetNumResourceMetadata(res, 'ui_page') do
				local typez = GetResourceMetadata(res, 'ui_page', i)
				local filed = LoadResourceFile(tostring(res), tostring(typez))
				if ResourceMetadata[res] == nil then
					ResourceMetadata[res] = {}
				end
				if ResourceFiles[res] == nil then
					ResourceFiles[res] = {}
				end
				if typez ~= nil then
					logged = true
					table.insert(ResourceMetadata[res], #typez)
				end
				if filed ~= nil then
					table.insert(ResourceFiles[res], #filed)
				end
			end
			if logged == true then
				SWPrintDebug("Added resource " .. res .. " to the server anticheat metafiles, this resource was not found when the anticheat first launched. This is a common issue with FiveM.")
				logged = false 
			end
			for k,v in pairs(Cfg.WhiteListedResources) do 
				if string.lower(v) == string.lower(res) then 
					ignoreBool = true
				end
			end
			if GetResourceState(res) == "started" or GetResourceState(res) == "starting" then
			else
				ignoreBool = true
			end
			Wait(1000)
			existInTable(res)
		end		
	end
    return ignoreBool
end

CreateThread(function()
    for i = 0, GetNumResources()-1, 1 do
		local resource = GetResourceByFindIndex(i)
		if GetResourceState(resource) == "started" or GetResourceState(resource) == "starting" then
			for i = 0, GetNumResourceMetadata(resource, 'client_script') do
				local typer = GetResourceMetadata(resource, 'client_script', i)
				local file = LoadResourceFile(tostring(resource), tostring(typer))
				if ResourceMetadata[resource] == nil then
					ResourceMetadata[resource] = {}
				end
				if ResourceFiles[resource] == nil then
					ResourceFiles[resource] = {}
				end
				if typer ~= nil then
					table.insert(ResourceMetadata[resource], #typer)
				end
				if file ~= nil then
					table.insert(ResourceFiles[resource], #file)
				end
			end
			for i = 0, GetNumResourceMetadata(resource, 'client_scripts') do
				local typere = GetResourceMetadata(resource, 'client_scripts', i)
				local file = LoadResourceFile(tostring(resource), tostring(typere))
				if ResourceMetadata[resource] == nil then
					ResourceMetadata[resource] = {}
				end
				if ResourceFiles[resource] == nil then
					ResourceFiles[resource] = {}
				end
				if typere ~= nil then
					table.insert(ResourceMetadata[resource], #typere)
				end
				if file ~= nil then
					table.insert(ResourceFiles[resource], #file)
				end
			end
			for i = 0, GetNumResourceMetadata(resource, 'ui_page') do
				local typez = GetResourceMetadata(resource, 'ui_page', i)
				local file = LoadResourceFile(tostring(resource), tostring(typez))
				if ResourceMetadata[resource] == nil then
					ResourceMetadata[resource] = {}
				end
				if ResourceFiles[resource] == nil then
					ResourceFiles[resource] = {}
				end
				if typez ~= nil then
					table.insert(ResourceMetadata[resource], #typez)
				end
				if file ~= nil then
					table.insert(ResourceFiles[resource], #file)
				end
			end
		end
    end
end)

RegisterNetEvent('sw:sendallresources')
AddEventHandler('sw:sendallresources', function(Metadata)
    local _src = source
    local _mdata = Metadata
    if _mdata ~= nil then
		if next(ResourceMetadata) then
			for k,v in pairs(_mdata) do
				if not existInTable(k) then
					if _src then
						if not ResourceMetadata[k] then
							if not tableHasValue(FoundCheaters, _src) then
								table.insert(FoundCheaters, _src)
								banplayer(_src, string.format(CfgSH.InjectionEvent2, "Resource injection. Resource (Not Isolated) "..k), nil, "Injections")
							end
						else
							if json.encode(ResourceMetadata[k]) ~= json.encode(_mdata[k]) then
								if not tableHasValue(FoundCheaters, _src) then
									table.insert(FoundCheaters, _src)
									banplayer(_src, string.format(CfgSH.InjectionEvent2, "Executor Detection (Eulen / Desudo) Resource: "..k), nil, "Injections")
									SWPrintDebug("Plus d'info sur cette detection : ", json.encode(ResourceMetadata[k]), json.encode(_mdata[k]))
								end
							end
						end
					end
				end
			end
			for k,v in pairs(ResourceMetadata) do
				if not existInTable(k) then
					if _src then
						if not _mdata[k] then
							if not tableHasValue(FoundCheaters, _src) then
								table.insert(FoundCheaters, _src)
								banplayer(_src, string.format(CfgSH.InjectionEvent2, "Injection: Resource stopped:"..k), nil, "Injections")
							end
						end
						if json.encode(_mdata[k]) ~= json.encode(ResourceMetadata[k]) then
							if not tableHasValue(FoundCheaters, _src) then
								table.insert(FoundCheaters, _src)
								banplayer(_src, string.format(CfgSH.InjectionEvent2, "Resource metadata not valid in resource:"..k), nil, "Injections")
								SWPrintDebug("Plus d'info sur cette detection : ", json.encode(ResourceMetadata[k]), json.encode(_mdata[k]))
							end
						end
					end
				end
			end
		end
    end
end)

CreateThread(function()
	while true do 
		Wait(8000)
		FoundCheaters = {}
	end
end)