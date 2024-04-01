Citizen.CreateThread(function()
    while RegisterServerCallback == nil do Wait(100) end

    RegisterServerCallback("core:GetStateMicrophone", function(source, token)
        if CheckPlayerToken(source, token) then
            local players = exports['pma-voice']:getStateMicrophone(source)
            return players
        end
    end)
end)