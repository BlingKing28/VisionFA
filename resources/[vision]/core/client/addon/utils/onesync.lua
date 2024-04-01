local token = nil

TriggerEvent("core:RequestTokenAcces", "core", function(t)
    token = t
end)

-- Fix onesync skin bug
-- https://canary.discord.com/channels/992031086555172895/992112234039881738/1067529304277274725
CreateThread(function()
    while not GetEntityModel(PlayerPedId()) do Wait(1) end
    while not TriggerServerCallback do Wait(1) end
    Wait(2000)
    local Activplayers = TriggerServerCallback("core:GetAllPlayer", token)
    print("Start experimental onesync")
    while true do 
        Wait(8000)
        local playerLoc = GetEntityCoords(PlayerPedId())
        local retval, gz = GetGroundZFor_3dCoord((playerLoc.x+0.0), (playerLoc.y+0.0), (playerLoc.z+0.0), Citizen.ReturnResultAnyway())
        SetGlobalMinBirdFlightHeight((gz+15))
    end
end)

CreateThread(function()
    local DensityMultiplier = 0.7
    while true do 
        Wait(1)
        local ClosestPlayers = #GetActivePlayers()
        local densityCalculator = DensityMultiplier - (ClosestPlayers/100)
        if (densityCalculator < 0 ) then densityCalculator = 0 end
        
        if ClosestPlayers > 50 then 
            SetVehicleDensityMultiplierThisFrame(0.0)
            SetPedDensityMultiplierThisFrame(0.1)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.1)
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
        else
            SetVehicleDensityMultiplierThisFrame(densityCalculator)
            SetPedDensityMultiplierThisFrame(densityCalculator)
            SetRandomVehicleDensityMultiplierThisFrame(densityCalculator)
            SetParkedVehicleDensityMultiplierThisFrame(densityCalculator)
        end
    end
end)