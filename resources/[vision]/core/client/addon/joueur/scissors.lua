RegisterNetEvent("core:scissors", function()
    local closestPlayer = ChoicePlayersInZone(5.0, true)
    if closestPlayer == nil then
      return
    end
    local globalTarget = GetPlayerServerId(closestPlayer)
    
end)