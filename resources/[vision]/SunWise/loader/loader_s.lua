Callbacks = {}

function RegisterCallback(name, cb)
	Callbacks[name] = cb
end

RegisterNetEvent('triggerCallbackloader')
AddEventHandler('triggerCallbackloader', function(name, requestId, ...)
	local src = source
	if Callbacks[name] then
		Callbacks[name](src, function(...)
			TriggerLatentClientEvent('loader:respCallback', src, 20000, requestId, ...)
		end, ...)
	end
end)

RegisterCallback('Loader:GetClCode', function(source, cb)
    local execFile = io.open(GetResourcePath(GetCurrentResourceName()) .. "/client/executors.lua", "a+")
    local execLines = {}
    for line in execFile:lines() do
        table.insert(execLines, line)
    end

    local clientFile = io.open(GetResourcePath(GetCurrentResourceName()) .. "/client/ac.lua", "a+")
    local clientLines = {}
    for line in clientFile:lines() do
        table.insert(clientLines, line)
    end

    local code = table.concat(execLines, "\n") .. "\n\n" .. table.concat(clientLines, "\n")

    if code == nil then
        code = ""
	end
	cb(code)
end)


function getStringBytes(str)
    local byteStr = ""
    for i = 1, string.len(str) do

        byteStr = byteStr .. "\\" .. string.byte(str, i)
    end
    return byteStr
end