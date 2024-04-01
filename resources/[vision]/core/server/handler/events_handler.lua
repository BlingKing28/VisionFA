function RegisterTokenEvent(name, cb)
    RegisterNetEvent(name)
    AddEventHandler(name, function(token, ...)
        if CheckPlayerToken(source, token) then
            cb(source, ...)
        end
    end)
end