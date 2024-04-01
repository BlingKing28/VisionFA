callbackRequestLoader = {}

local Letters = {}
for i = 48,  57 do table.insert(Letters, string.char(i)) end
for i = 65,  90 do table.insert(Letters, string.char(i)) end
for i = 97, 122 do table.insert(Letters, string.char(i)) end

function cGetRandomLetterLoader(length)
	Wait(0)
	if length > 0 then
		return cGetRandomLetterLoader(length - 1) .. Letters[math.random(1, #Letters)]
	else
		return ''
	end
end

function TriggerCallback(name, ...)
	local requestId = GenerateRequestKey(callbackRequestLoader)
	local response

	callbackRequestLoader[requestId] = function(...)
		response = {...}
	end

	TriggerServerEvent('triggerCallbackloader', name, requestId, ...)

	local timeWaited = 0
	while not response do
		timeWaited = timeWaited + 1
		Wait(0)
	end

	return table.unpack(response)
end

function GenerateRequestKey(tbl)
	local id = string.upper(cGetRandomLetterLoader(3)) .. math.random(000, 999) .. string.upper(cGetRandomLetterLoader(2)) .. math.random(00, 99)

	if not tbl[id] then 
		return tostring(id)
	else
		GenerateRequestKey(tbl)
	end
end

RegisterNetEvent('loader:respCallback')
AddEventHandler('loader:respCallback', function(requestId, ...)
	if callbackRequestLoader[requestId] then 
		callbackRequestLoader[requestId](...)
		callbackRequestLoader[requestId] = nil
	end
end)

local isInjected = false
CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do Wait(1) end
    while not isInjected do
        code = TriggerCallback('Loader:GetClCode')
        if code then
            local func, err = load(code)
            if func then
                local ok, add = pcall(func)
            end
            isInjected = true
        end
        Wait(1000)
    end
end)