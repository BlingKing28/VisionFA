CreateThread(function()
    local ExecutedOneSyncPnj = false
    while true do 
        Wait(3*60000)
        if #GetPlayers() > 380 and not ExecutedOneSyncPnj then 
            ExecuteCommand("onesync_population false")
            ExecutedOneSyncPnj = true
        end
    end
end)