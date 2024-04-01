RegisterNetEvent('core:loadVariables')
AddEventHandler('core:loadVariables', function(token)
    local _src = source

    if not CheckPlayerToken(_src, token) then return end

    print("Loading variables for " .. GetPlayerName(_src))

    print(json.encode(GetVariables()))

    TriggerClientEvent('core:getVariables', _src, GetVariables())
end)

RegisterNetEvent('core:updateVariable')
AddEventHandler('core:updateVariable', function(token, name, value)
    local _src = source

    if not CheckPlayerToken(_src, token) then return end

    print("Updating variable " .. name .. " to " .. json.encode(value))

    SetVariable(name, value)
    TriggerClientEvent('core:updateVariable', -1, name, value)
end)