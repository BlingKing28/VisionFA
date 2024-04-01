function UpdateRichPresence(source)
    local number = #GetPlayers()
    TriggerClientEvent("core:UpdateRichPresence", -1, number)
end

CreateThread(function ()
    while true do
        Wait(60*1000)
        UpdateRichPresence()
    end
end)